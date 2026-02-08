#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlips(char** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int flips = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols / 2; j++) {
            if (grid[i][j] != grid[i][cols - 1 - j]) {
                flips++;
            }
        }
    }

    for (int j = 0; j < cols; j++) {
        for (int i = 0; i < rows / 2; i++) {
            if (grid[i][j] != grid[rows - 1 - i][j]) {
                flips++;
            }
        }
    }

    return flips;
}