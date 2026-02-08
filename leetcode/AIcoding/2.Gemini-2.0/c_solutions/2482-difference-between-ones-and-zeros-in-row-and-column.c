#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** onesMinusZeros(int** grid, int gridSize, int* gridColSize, int** returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    int* rowOnes = (int*)malloc(m * sizeof(int));
    int* colOnes = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < m; i++) {
        rowOnes[i] = 0;
        for (int j = 0; j < n; j++) {
            rowOnes[i] += grid[i][j];
        }
    }

    for (int j = 0; j < n; j++) {
        colOnes[j] = 0;
        for (int i = 0; i < m; i++) {
            colOnes[j] += grid[i][j];
        }
    }

    int** diff = (int**)malloc(m * sizeof(int*));
    *returnSize = (int*)malloc(sizeof(int));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    (*returnSize)[0] = m;

    for (int i = 0; i < m; i++) {
        diff[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            diff[i][j] = 2 * rowOnes[i] + 2 * colOnes[j] - m - n;
        }
    }

    free(rowOnes);
    free(colOnes);

    return diff;
}