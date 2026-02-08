#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int surfaceArea(int** grid, int gridSize, int* gridColSize){
    int area = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > 0) {
                area += 2;
                area += grid[i][j] * 4;

                if (i > 0) {
                    area -= fmin(grid[i][j], grid[i - 1][j]);
                }
                if (i < gridSize - 1) {
                    area -= fmin(grid[i][j], grid[i + 1][j]);
                }
                if (j > 0) {
                    area -= fmin(grid[i][j], grid[i][j - 1]);
                }
                if (j < gridColSize[i] - 1) {
                    area -= fmin(grid[i][j], grid[i][j + 1]);
                }
            }
        }
    }
    return area;
}