#include <stdio.h>
#include <stdlib.h>

int maxMoney(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    for (int i = 1; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (j == 0) {
                grid[i][j] += grid[i-1][j];
            } else if (j == cols - 1) {
                grid[i][j] += grid[i-1][j-1];
            } else {
                grid[i][j] += (grid[i-1][j-1] > grid[i-1][j]) ? grid[i-1][j-1] : grid[i-1][j];
            }
        }
    }

    int max = grid[rows-1][0];
    for (int j = 1; j < cols; j++) {
        if (grid[rows-1][j] > max) {
            max = grid[rows-1][j];
        }
    }

    return max;
}