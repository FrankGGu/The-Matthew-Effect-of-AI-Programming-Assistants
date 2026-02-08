#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void fillGrid(int n, int grid[][n]);

void fillGrid(int n, int grid[][n]) {
    if (n == 1) {
        grid[0][0] = 1;
        return;
    }

    if (n == 2) {
        grid[0][0] = 1;
        grid[0][1] = 1;
        grid[1][0] = 1;
        grid[1][1] = 0;
        return;
    }

    int subGridSize = n / 2;
    int subGrid[subGridSize][subGridSize];
    fillGrid(subGridSize, subGrid);

    for (int i = 0; i < subGridSize; i++) {
        for (int j = 0; j < subGridSize; j++) {
            grid[i][j] = subGrid[i][j];
            grid[i][j + subGridSize] = subGrid[i][j];
            grid[i + subGridSize][j] = subGrid[i][j];
            grid[i + subGridSize][j + subGridSize] = !subGrid[i][j];
        }
    }
}