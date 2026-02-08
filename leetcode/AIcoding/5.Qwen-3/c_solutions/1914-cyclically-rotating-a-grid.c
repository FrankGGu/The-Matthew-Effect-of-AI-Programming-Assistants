#include <stdio.h>
#include <stdlib.h>

int** rotateGrid(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    int total = rows * cols;
    int* flat = (int*)malloc(total * sizeof(int));
    int idx = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            flat[idx++] = grid[i][j];
        }
    }

    int shift = k % total;
    if (shift == 0) {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                result[i][j] = grid[i][j];
            }
        }
        free(flat);
        return result;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int pos = i * cols + j;
            int new_pos = (pos + shift) % total;
            result[i][j] = flat[new_pos];
        }
    }

    free(flat);
    return result;
}