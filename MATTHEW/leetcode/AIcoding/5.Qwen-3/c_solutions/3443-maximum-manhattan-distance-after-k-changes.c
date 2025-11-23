#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maximumManhattanDistance(int** grid, int gridSize, int* gridColSize, int k) {
    int n = gridSize;
    int m = *gridColSize;

    int* row = (int*)malloc(n * sizeof(int));
    int* col = (int*)malloc(m * sizeof(int));

    for (int i = 0; i < n; i++) {
        row[i] = 0;
        for (int j = 0; j < m; j++) {
            row[i] += grid[i][j];
        }
    }

    for (int j = 0; j < m; j++) {
        col[j] = 0;
        for (int i = 0; i < n; i++) {
            col[j] += grid[i][j];
        }
    }

    qsort(row, n, sizeof(int), (int (*)(const void*, const void*))strcmp);
    qsort(col, m, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int maxRow = 0;
    int minRow = 0;
    for (int i = 0; i < n; i++) {
        if (i < k) {
            maxRow += row[n - 1 - i];
            minRow += row[i];
        } else {
            maxRow += row[n - 1 - i];
            minRow += row[i];
        }
    }

    int maxCol = 0;
    int minCol = 0;
    for (int j = 0; j < m; j++) {
        if (j < k) {
            maxCol += col[m - 1 - j];
            minCol += col[j];
        } else {
            maxCol += col[m - 1 - j];
            minCol += col[j];
        }
    }

    int result = (maxRow - minRow) + (maxCol - minCol);
    free(row);
    free(col);
    return result;
}