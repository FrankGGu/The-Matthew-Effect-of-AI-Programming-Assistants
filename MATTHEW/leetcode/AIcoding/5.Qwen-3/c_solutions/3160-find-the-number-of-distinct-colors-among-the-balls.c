#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int uniqueColors(int** balls, int ballsSize, int* ballsColSize) {
    bool colorSet[1000] = {false};
    int count = 0;

    for (int i = 0; i < ballsSize; i++) {
        for (int j = 0; j < ballsColSize[i]; j++) {
            int color = balls[i][j];
            if (!colorSet[color]) {
                colorSet[color] = true;
                count++;
            }
        }
    }

    return count;
}