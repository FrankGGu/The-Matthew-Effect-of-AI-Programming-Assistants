#include <stdio.h>
#include <stdlib.h>

int minOperations(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int operations = 0;

    for (int j = 0; j < cols; j++) {
        for (int i = 1; i < rows; i++) {
            if (grid[i][j] > grid[i - 1][j]) {
                continue;
            } else {
                int needed = grid[i - 1][j] + 1;
                operations += needed - grid[i][j];
                grid[i][j] = needed;
            }
        }
    }

    return operations;
}