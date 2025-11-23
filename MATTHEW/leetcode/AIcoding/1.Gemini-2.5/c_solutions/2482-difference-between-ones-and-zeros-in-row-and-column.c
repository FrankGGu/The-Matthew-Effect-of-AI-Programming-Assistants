#include <stdlib.h> // Required for malloc, calloc, free

int** onesZeros(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    int* onesRow = (int*)calloc(m, sizeof(int));
    int* onesCol = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                onesRow[i]++;
                onesCol[j]++;
            }
        }
    }

    int** diff = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));

    for (int i = 0; i < m; i++) {
        diff[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            // Using the simplified formula: diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - n - m
            diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - n - m;
        }
    }

    *returnSize = m;

    free(onesRow);
    free(onesCol);

    return diff;
}