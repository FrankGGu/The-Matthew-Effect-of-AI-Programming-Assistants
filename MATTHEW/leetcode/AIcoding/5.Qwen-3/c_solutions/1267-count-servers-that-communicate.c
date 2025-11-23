#include <stdio.h>
#include <stdlib.h>

int countServers(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int* row_count = (int*)calloc(rows, sizeof(int));
    int* col_count = (int*)calloc(cols, sizeof(int));
    int count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                row_count[i]++;
                col_count[j]++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1 && (row_count[i] > 1 || col_count[j] > 1)) {
                count++;
            }
        }
    }

    free(row_count);
    free(col_count);
    return count;
}