#include <stdio.h>
#include <stdlib.h>

int numberOfRightTriangles(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int* row_counts = (int*)malloc(rows * sizeof(int));
    int* col_counts = (int*)malloc(cols * sizeof(int));

    for (int i = 0; i < rows; i++) {
        row_counts[i] = 0;
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                row_counts[i]++;
            }
        }
    }

    for (int j = 0; j < cols; j++) {
        col_counts[j] = 0;
        for (int i = 0; i < rows; i++) {
            if (grid[i][j] == 1) {
                col_counts[j]++;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                result += (row_counts[i] - 1) * (col_counts[j] - 1);
            }
        }
    }

    free(row_counts);
    free(col_counts);
    return result;
}