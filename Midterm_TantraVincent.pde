import processing.sound.*;
import ddf.minim.analysis.*;
import ddf.minim.*;


// files for audio
SoundFile file;
String audioName = "freedomdive.mp3";
int clock;
int fps = 30;

// visualizer related things
Minim minim;
AudioPlayer song;
ddf.minim.analysis.FFT fft;

// variables for text
// Title text
PFont titleText;
boolean titleUp = true;
int titleTime = 300;

// Pause text
PFont pauseText;

// background colors and variables
color currBG = #5894C6;
color normalBG = #64F774;
color hypeBG = #6CDEFF;
color restBG = #F7E37A;
boolean updateBG = false;

// hit shape variable
ArrayList<float[]> hitShapes;

// addon visual variables
float xPos = 0;
float yPos = 0;
//float confetti_rotation = 7;
int num_falling = 20;
float fallSpeed = 3;
float falling[][];
color falling_colors[];
color c1 = #F5BEC6;
color c2 = #D9BADB;
color c3 = #A4CAFA;
color c4 = #C6F2DD;
color c5 = #B8F7AF;
color c6 = #F6F7AF;
color c7 = #F5D974;
color c8 = #F5B994;
boolean back = false;
color[] colors  = {  
  c1, c2, c3, c4, c5, c6, c7, c8
};
int thingFalling = 0;


// other functionality
boolean paused = false;
boolean justUnpaused = false;

void setup() {
  // scene setup
  size(800,800);
  background(#5894C6);
  frameRate(fps);
  
  // audio setup
  file = new SoundFile(this, "freedomdive.mp3");
  file.play();
  
  // text setup
  titleText = createFont("Segoe UI Semibold Italic", 16, true);
  pauseText = createFont("Leelawadee UI Bold", 16, true);
  
  // clock setup
  clock = 0;
  
  // visualizer setup
  minim = new Minim(this);
  song = minim.loadFile("freedomdive.mp3");
  fft = new ddf.minim.analysis.FFT(song.bufferSize(), song.sampleRate());
  
  // hit shapes setup
  hitShapes = new ArrayList<float[]>();
  
  // print title card
  printTitleCard();
}
  
  
void draw() {
  // check if paused
  if (!paused) {
    background(currBG);
    printTitleCard();
    // check if we remove title
    if (clock > titleTime) {
      removeTitleCard();
    }
    
    // check if we remove pause
    if (justUnpaused) {
      removePausedCard();
    }
    
    // check if we update background
    //if (updateBG) {
    //  background(currBG);
    //  updateBG = false;
    //}
    
    
    // render visual addons
    if (thingFalling == 1) {
      drawFallingLine();
    } else if (thingFalling == 2) {
      drawFallingRect();
    } else if (thingFalling == 3) {
      drawFallingCirc();
    } else if (thingFalling ==4) {
      drawFalling();
    }
    
    visualize();
    
    // draw hit shapes
    drawHitShapes();
    
    clock++;
  } else {
    printPausedCard();
  }
}


// printing and removing title card
void printTitleCard() {
  textFont(titleText, 40);
  fill(255);
  textAlign(CENTER);
  text("Freedom Dive", 400, 400);
}


void removeTitleCard() {
  fill(currBG);
  rectMode(CENTER);
  noStroke();
  rect(400, 400, 260, 70);
}


// printing and removing paused card
void printPausedCard() {
  textFont(pauseText, 30);
  fill(255);
  textAlign(CENTER);
  text("PAUSED", 400, 400);
  justUnpaused = true;
  file.pause();
}


void removePausedCard() {
  fill(currBG);
  rectMode(CENTER);
  noStroke();
  rect(400, 400, 200, 70);
  justUnpaused = false;
  file.play();
  
}

// draw hit shapes
void drawHitShapes() {
  for (float[] shape : hitShapes) {
    fill(255, shape[2]);
    stroke(0);
    if (thingFalling == 1) {
      stroke(#00FF00);
    } else if (thingFalling == 2) {
      stroke(#0000FF);
    } else if (thingFalling == 3) {
      stroke(#FF0000);
    }
    strokeWeight(2);
    ellipse(shape[0], shape[1], 60, 60);
    shape[2] = shape[2] - 5;
  }
  for (int i = hitShapes.size(); i > 0; i--) {
    if (hitShapes.get(i - 1)[2] <= 0) {
      hitShapes.remove(i - 1);
    }
  }
}

// visualizer, concept courtesy of LearnEDU
void visualize() {
  //fft.forward(song.mix);
  
  //for (int i = 0; i < fft.specSize(); i++) {
  //  ellipse(i, 200, 7, fft.getBand(i) * 10);
  //}
  //for (int i = 0; i < song.mix.size(); i++) {
  //  float x = map(i, 0, song.mix.size() - 1, 0, width);
  //  float y = map(song.mix.get(i), 1, -1, 0, height);
  //  line(x, height/2, x, y);
  //}
}


void setupLines() {
  // we should be setting up falling lines
  falling = new float[num_falling][3];
  for (int i = 0; i < num_falling; i++) {
    falling[i][0] = random(width);
    falling[i][1] = random(height);
  }
  
  falling_colors = new color[num_falling];
  for (int i = 0; i < num_falling; i++) {
    falling_colors[i] = colors[int(random(colors.length))];
  }
}


void setupRects() {
  // we should be setting up falling rects
  falling = new float[num_falling][3];
  for (int i = 0; i < num_falling; i++) {
    falling[i][0] = random(width);
    falling[i][1] = random(height);
  }
  
  falling_colors = new color[num_falling];
  for (int i = 0; i < num_falling; i++) {
    falling_colors[i] = colors[int(random(colors.length))];
  }
}

void setupCircs() {
  // we should be setting up falling circles
  falling = new float[num_falling][3];
  for (int i = 0; i < num_falling; i++) {
    falling[i][0] = random(width);
    falling[i][1] = random(height);
  }
  
  falling_colors = new color[num_falling];
  for (int i = 0; i < num_falling; i++) {
    falling_colors[i] = colors[int(random(colors.length))];
  }
}


void setupDrip() {
  // we should be setting up falling drips
  falling = new float[num_falling][3];
  for (int i = 0; i < num_falling; i++) {
    falling[i][0] = random(width);
    falling[i][1] = random(height);
  }
  
  falling_colors = new color[num_falling];
  for (int i = 0; i < num_falling; i++) {
    falling_colors[i] = colors[int(random(colors.length))];
  }
}


void drawFallingLine() {
  for (int i = 0; i < num_falling; i++) {
    if (yPos + falling[i][1] > (height + 50)) {
      falling[i][1] = -50;
    } else {
      falling[i][1] = falling[i][1] + fallSpeed;
    }
    drawFallingLineHelper(falling[i][0], falling[i][1], falling_colors[i]);
  }
}

void drawFallingLineHelper(float x, float y, color c) {
  pushMatrix();
  rectMode(CENTER);
  translate(x, y);
  stroke(c);
  strokeWeight(5);
  line(0, 0, 0, 120);
  popMatrix();
}


void drawFallingRect() {
  for (int i = 0; i < num_falling; i++) {
    if (yPos + falling[i][1] > (height + 50)) {
      falling[i][1] = -50;
    } else {
      falling[i][1] = falling[i][1] + fallSpeed;
    }
    drawFallingRectHelper(falling[i][0], falling[i][1], falling_colors[i]);
  }
}

void drawFallingRectHelper(float x, float y, color c) {
  pushMatrix();
  rectMode(CENTER);
  translate(x, y);
  noStroke();
  fill(c, 90);
  rect(0, 0, 40, 100);
  popMatrix();
}


void drawFallingCirc() {
  for (int i = 0; i < num_falling; i++) {
    if (yPos + falling[i][1] > (height + 50)) {
      falling[i][1] = -50;
    } else {
      falling[i][1] = falling[i][1] + fallSpeed;
    }
    drawFallingCircHelper(falling[i][0], falling[i][1], falling_colors[i]);
  }
}

void drawFallingCircHelper(float x, float y, color c) {
  pushMatrix();
  rectMode(CENTER);
  translate(x, y);
  noStroke();
  fill(c, 80);
  int randomRadius = 30 + int(random(20));
  ellipse(0, 0, randomRadius, randomRadius);
  popMatrix();
}


void drawFalling() {
  for (int i = 0; i < num_falling; i++) {
    if (yPos + falling[i][1] > (height + 50)) {
      falling[i][1] = -50;
    } else {
      falling[i][1] = falling[i][1] + fallSpeed;
    }
    drawFallingHelper(falling[i][0], falling[i][1], falling_colors[i]);
  }
}

void drawFallingHelper(float x, float y, color c) {
  pushMatrix();
  rectMode(CENTER);
  translate(x, y);
  noStroke();
  fill(c);
  rect(0, 0, 20, 20);
  popMatrix();
}


// key bindings
void keyPressed() {
  if (key == 'j') {
    currBG = normalBG;
    updateBG = true;
  } else if (key == 'k') {
    currBG = hypeBG;
    updateBG = true;
  } else if (key == 'l') {
    currBG = restBG;
    updateBG = true;
  }
  if (key == ' ') {
    paused = !paused;
  }
  if (key == 'u') {
    thingFalling = 1;
    setupLines();
  } else if (key == 'i') {
    thingFalling = 2;
    setupRects();
  } else if (key == 'o') {
    thingFalling = 3;
    setupCircs();
  } else if (key == 'p') {
    thingFalling = 4;
    setupDrip();
  } else if (key == 'y') {
    thingFalling = 0;
  }
  if (key == 'z' || key == 'x') {
    if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
      float[] newShape = {mouseX, mouseY, 100};
      hitShapes.add(newShape);
    }
  } 
  if (key == 'n') {
    fallSpeed += 0.1;
  } else if (key == 'm') {
    fallSpeed -= 0.1;
  }
}
