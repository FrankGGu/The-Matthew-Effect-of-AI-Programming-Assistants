#include <stdio.h>
#include <stdlib.h>

int* findDiagonalOrder(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int maxRow = gridSize;
    int maxCol = gridColSize[0];
    int total = 0;
    for (int i = 0; i < gridSize; i++) {
        total += gridColSize[i];
    }

    int* result = (int*)malloc(total * sizeof(int));
    *returnSize = 0;

    int** rows = (int**)malloc((maxRow + maxCol) * sizeof(int*));
    for (int i = 0; i < maxRow + maxCol; i++) {
        rows[i] = (int*)malloc(0);
    }

    for (int row = 0; row < maxRow; row++) {
        for (int col = 0; col < gridColSize[row]; col++) {
            int sum = row + col;
            int size = (int)(sizeof(rows[sum]) / sizeof(int));
            rows[sum] = (int*)realloc(rows[sum], (size + 1) * sizeof(int));
            rows[sum][size] = grid[row][col];
        }
    }

    for (int i = 0; i < maxRow + maxCol; i++) {
        int size = (int)(sizeof(rows[i]) / sizeof(int));
        for (int j = size - 1; j >= 0; j--) {
            result[*returnSize] = rows[i][j];
            (*returnSize)++;
        }
    }

    for (int i = 0; i < maxRow + maxCol; i++) {
        free(rows[i]);
    }
    free(rows);

    return result;
}