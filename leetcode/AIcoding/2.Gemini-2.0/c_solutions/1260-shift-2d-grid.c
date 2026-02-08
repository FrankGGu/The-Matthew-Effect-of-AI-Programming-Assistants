#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** shiftGrid(int** grid, int gridSize, int* gridColSize, int k, int* returnSize, int** returnColumnSizes){
    int rows = gridSize;
    int cols = *gridColSize;
    int totalElements = rows * cols;

    k = k % totalElements;

    int** result = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));

    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
    }

    *returnSize = rows;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int originalIndex = (i * cols + j);
            int newIndex = (originalIndex + k) % totalElements;

            int newRow = newIndex / cols;
            int newCol = newIndex % cols;

            result[newRow][newCol] = grid[i][j];
        }
    }

    return result;
}