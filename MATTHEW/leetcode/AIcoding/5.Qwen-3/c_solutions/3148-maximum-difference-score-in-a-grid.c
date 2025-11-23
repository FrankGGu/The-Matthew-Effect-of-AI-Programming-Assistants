#include <stdio.h>
#include <stdlib.h>

int maximumDifference(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int maxDiff = -1;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            for (int k = i + 1; k < rows; k++) {
                for (int l = 0; l < cols; l++) {
                    int diff = grid[k][l] - grid[i][j];
                    if (diff > maxDiff) {
                        maxDiff = diff;
                    }
                }
            }
        }
    }

    return maxDiff;
}