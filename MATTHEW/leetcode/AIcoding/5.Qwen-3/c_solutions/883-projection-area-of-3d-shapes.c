#include <stdio.h>
#include <stdlib.h>

int projectionArea(int** grid, int gridSize, int* gridColSize) {
    int area = 0;
    int maxRow, maxCol;

    for (int i = 0; i < gridSize; i++) {
        maxRow = 0;
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > 0) {
                area++;
            }
            if (grid[i][j] > maxRow) {
                maxRow = grid[i][j];
            }
        }
        area += maxRow;
    }

    for (int j = 0; j < gridColSize[0]; j++) {
        maxCol = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] > maxCol) {
                maxCol = grid[i][j];
            }
        }
        area += maxCol;
    }

    return area;
}