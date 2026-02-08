#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* gridIllumination(int** grid, int gridSize, int* gridColSize, int* queries, int queriesSize, int* returnSize) {
    int n = gridSize;
    int m = gridColSize[0];
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int* row_counts = (int*)calloc(n, sizeof(int));
    int* col_counts = (int*)calloc(m, sizeof(int));
    int* diag1_counts = (int*)calloc(2 * n, sizeof(int));
    int* diag2_counts = (int*)calloc(2 * n, sizeof(int));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                row_counts[i]++;
                col_counts[j]++;
                diag1_counts[i - j + n]++;
                diag2_counts[i + j]++;
            }
        }
    }

    for (int q = 0; q < queriesSize; q++) {
        int x = queries[q] / m;
        int y = queries[q] % m;

        if (row_counts[x] > 0 || col_counts[y] > 0 || diag1_counts[x - y + n] > 0 || diag2_counts[x + y] > 0) {
            result[q] = 1;
        } else {
            result[q] = 0;
        }

        if (grid[x][y] == 1) {
            row_counts[x]--;
            col_counts[y]--;
            diag1_counts[x - y + n]--;
            diag2_counts[x + y]--;
            grid[x][y] = 0;
        }
    }

    free(row_counts);
    free(col_counts);
    free(diag1_counts);
    free(diag2_counts);

    return result;
}