#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int projectionArea(int** grid, int gridSize, int* gridColSize){
    int xyArea = 0;
    int xzArea = 0;
    int yzArea = 0;
    int maxRow[gridSize];
    int maxCol[*gridColSize];

    for (int i = 0; i < gridSize; i++) {
        maxRow[i] = 0;
    }
    for (int j = 0; j < *gridColSize; j++) {
        maxCol[j] = 0;
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] > 0) {
                xyArea++;
            }
            if (grid[i][j] > maxRow[i]) {
                maxRow[i] = grid[i][j];
            }
            if (grid[i][j] > maxCol[j]) {
                maxCol[j] = grid[i][j];
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        xzArea += maxRow[i];
    }
    for (int j = 0; j < *gridColSize; j++) {
        yzArea += maxCol[j];
    }

    return xyArea + xzArea + yzArea;
}