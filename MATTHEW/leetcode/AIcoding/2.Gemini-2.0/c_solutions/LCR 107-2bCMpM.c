#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** updateMatrix(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes){
    int rows = matSize;
    int cols = *matColSize;
    int** dist = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    *returnSize = rows;
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
        for (int j = 0; j < cols; j++) {
            if (mat[i][j] == 0) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = INT_MAX - 1;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (i > 0) {
                dist[i][j] = fmin(dist[i][j], dist[i - 1][j] + 1);
            }
            if (j > 0) {
                dist[i][j] = fmin(dist[i][j], dist[i][j - 1] + 1);
            }
        }
    }

    for (int i = rows - 1; i >= 0; i--) {
        for (int j = cols - 1; j >= 0; j--) {
            if (i < rows - 1) {
                dist[i][j] = fmin(dist[i][j], dist[i + 1][j] + 1);
            }
            if (j < cols - 1) {
                dist[i][j] = fmin(dist[i][j], dist[i][j + 1] + 1);
            }
        }
    }

    return dist;
}