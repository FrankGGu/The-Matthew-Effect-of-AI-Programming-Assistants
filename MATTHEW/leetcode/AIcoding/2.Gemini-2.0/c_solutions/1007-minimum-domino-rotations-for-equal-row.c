#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDominoRotations(int* tops, int topsSize, int* bottoms, int bottomsSize) {
    int num = tops[0];
    int top_rotations = 0;
    int bottom_rotations = 0;
    int possible = 1;

    for (int i = 0; i < topsSize; i++) {
        if (tops[i] != num && bottoms[i] != num) {
            possible = 0;
            break;
        }
        if (tops[i] != num) {
            top_rotations++;
        }
        if (bottoms[i] != num) {
            bottom_rotations++;
        }
    }

    if (possible) {
        return (top_rotations < bottom_rotations) ? top_rotations : bottom_rotations;
    }

    num = bottoms[0];
    top_rotations = 0;
    bottom_rotations = 0;
    possible = 1;

    for (int i = 0; i < topsSize; i++) {
        if (tops[i] != num && bottoms[i] != num) {
            possible = 0;
            break;
        }
        if (tops[i] != num) {
            top_rotations++;
        }
        if (bottoms[i] != num) {
            bottom_rotations++;
        }
    }

    if (possible) {
        return (top_rotations < bottom_rotations) ? top_rotations : bottom_rotations;
    }

    return -1;
}