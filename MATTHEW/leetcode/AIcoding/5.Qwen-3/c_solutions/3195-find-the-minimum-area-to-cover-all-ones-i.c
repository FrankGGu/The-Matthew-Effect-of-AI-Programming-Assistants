#include <stdio.h>
#include <stdlib.h>

int minimumArea(int** grid, int gridSize, int* gridColSize) {
    int minRow = gridSize, maxRow = -1, minCol = *gridColSize, maxCol = -1;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == 1) {
                if (i < minRow) minRow = i;
                if (i > maxRow) maxRow = i;
                if (j < minCol) minCol = j;
                if (j > maxCol) maxCol = j;
            }
        }
    }

    return (maxRow - minRow + 1) * (maxCol - minCol + 1);
}