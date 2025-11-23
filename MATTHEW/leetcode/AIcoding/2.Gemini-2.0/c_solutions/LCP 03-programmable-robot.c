#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool robot(int width, int height, int steps, char *moves) {
    int x = 0, y = 0;
    int direction = 0; 
    int movesLen = strlen(moves);

    for (int i = 0; i < steps; i++) {
        char move = moves[i % movesLen];

        if (move == 'U') {
            y = (y + 1) % height;
            if (y == 0) direction = 0; 
        } else if (move == 'R') {
            x = (x + 1) % width;
            if (x == 0) direction = 1;
        } else if (move == 'D') {
            y = (y - 1 + height) % height;
            if (y == height - 1) direction = 2;
        } else { 
            x = (x - 1 + width) % width;
            if (x == width - 1) direction = 3;
        }
    }

    if (x == 0 && y == 0) {
        if (width == 1 && height == 1) return true;
        if (width > 1 && height > 1) {
            if (direction == 0) return true;
            else return false;
        }
        else if (width > 1){
            if (direction == 1) return true;
            else return false;
        }
        else {
            if(direction == 0) return true;
            else return false;
        }
    }
    else return false;
}