#include <stdio.h>
#include <stdlib.h>

int** shiftGrid(int** grid, int gridSize, int* gridColSize, int k, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int total = rows * cols;
    int* flat = (int*)malloc(total * sizeof(int));
    int** result = (int**)malloc(rows * sizeof(int*));

    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            flat[i * cols + j] = grid[i][j];
        }
    }

    k = k % total;
    int shift = total - k;

    for (int i = 0; i < total; i++) {
        int new_idx = (i + shift) % total;
        int row = new_idx / cols;
        int col = new_idx % cols;
        result[row][col] = flat[i];
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    free(flat);
    return result;
}