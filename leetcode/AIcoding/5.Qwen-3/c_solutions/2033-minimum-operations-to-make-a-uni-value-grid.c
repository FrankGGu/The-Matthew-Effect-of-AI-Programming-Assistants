#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minOperations(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int* flat = (int*)malloc(rows * cols * sizeof(int));
    int index = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            flat[index++] = grid[i][j];
        }
    }

    qsort(flat, rows * cols, sizeof(int), (int(*)(const void*, const void*))strcmp);

    int median = flat[(rows * cols) / 2];
    int operations = 0;

    for (int i = 0; i < rows * cols; i++) {
        operations += abs(flat[i] - median);
    }

    free(flat);
    return operations;
}