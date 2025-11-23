#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int rows;
    int cols;
    int** matrix;
} Matrix;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int** createMatrix(int rows, int cols) {
    int** matrix = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        matrix[i] = (int*)malloc(cols * sizeof(int));
    }
    return matrix;
}

void freeMatrix(int** matrix, int rows) {
    for (int i = 0; i < rows; i++) {
        free(matrix[i]);
    }
    free(matrix);
}

int isSimilar(int** matrix, int rows, int cols) {
    int* firstRow = (int*)malloc(cols * sizeof(int));
    memcpy(firstRow, matrix[0], cols * sizeof(int));
    qsort(firstRow, cols, sizeof(int), compare);

    for (int i = 1; i < rows; i++) {
        int* currentRow = (int*)malloc(cols * sizeof(int));
        memcpy(currentRow, matrix[i], cols * sizeof(int));
        qsort(currentRow, cols, sizeof(int), compare);
        if (memcmp(currentRow, firstRow, cols * sizeof(int)) != 0) {
            free(currentRow);
            free(firstRow);
            return 0;
        }
        free(currentRow);
    }

    free(firstRow);
    return 1;
}

int** shiftGrid(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int total = rows * cols;
    int* flat = (int*)malloc(total * sizeof(int));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            flat[i * cols + j] = grid[i][j];
        }
    }

    int shift = k % total;
    int* shifted = (int*)malloc(total * sizeof(int));
    for (int i = 0; i < total; i++) {
        shifted[(i + shift) % total] = flat[i];
    }

    int** result = createMatrix(rows, cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[i][j] = shifted[i * cols + j];
        }
    }

    free(flat);
    free(shifted);
    return result;
}

bool areSimilar(int** grid1, int gridSize1, int* gridColSize1, int** grid2, int gridSize2, int* gridColSize2) {
    if (gridSize1 != gridSize2 || gridColSize1[0] != gridColSize2[0]) {
        return false;
    }

    int rows = gridSize1;
    int cols = gridColSize1[0];

    int** shiftedGrid = shiftGrid(grid1, rows, gridColSize1, 1);
    for (int k = 0; k < rows * cols; k++) {
        if (isSimilar(shiftedGrid, rows, cols)) {
            freeMatrix(shiftedGrid, rows);
            return true;
        }
        freeMatrix(shiftedGrid, rows);
        shiftedGrid = shiftGrid(grid1, rows, gridColSize1, k + 1);
    }

    freeMatrix(shiftedGrid, rows);
    return false;
}