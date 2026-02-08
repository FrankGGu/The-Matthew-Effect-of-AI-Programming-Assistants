#include <stdio.h>
#include <stdlib.h>

int* countServers(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int* row_counts = (int*)calloc(rows, sizeof(int));
    int* col_counts = (int*)calloc(cols, sizeof(int));
    int* result = (int*)malloc(rows * cols * sizeof(int));
    int count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                row_counts[i]++;
                col_counts[j]++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0 && row_counts[i] + col_counts[j] > 0) {
                result[count++] = 1;
            } else {
                result[count++] = 0;
            }
        }
    }

    *returnSize = rows * cols;
    return result;
}