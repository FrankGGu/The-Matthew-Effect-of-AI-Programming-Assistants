#include <stdio.h>
#include <stdlib.h>

bool satisfiesConditions(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (i > 0 && grid[i][j] <= grid[i-1][j]) return false;
            if (j > 0 && grid[i][j] <= grid[i][j-1]) return false;
        }
    }

    return true;
}