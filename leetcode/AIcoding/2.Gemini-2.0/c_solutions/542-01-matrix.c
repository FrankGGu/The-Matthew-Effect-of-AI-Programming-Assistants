#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_INT 2147483647

int** updateMatrix(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int rows = matSize;
    int cols = matColSize[0];

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            if (mat[i][j] == 0) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = MAX_INT;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (mat[i][j] != 0) {
                if (i > 0) {
                    dist[i][j] = (dist[i][j] < dist[i - 1][j] + 1) ? dist[i][j] : dist[i - 1][j] + 1;
                }
                if (j > 0) {
                    dist[i][j] = (dist[i][j] < dist[i][j - 1] + 1) ? dist[i][j] : dist[i][j - 1] + 1;
                }
            }
        }
    }

    for (int i = rows - 1; i >= 0; i--) {
        for (int j = cols - 1; j >= 0; j--) {
            if (mat[i][j] != 0) {
                if (i < rows - 1) {
                    dist[i][j] = (dist[i][j] < dist[i + 1][j] + 1) ? dist[i][j] : dist[i + 1][j] + 1;
                }
                if (j < cols - 1) {
                    dist[i][j] = (dist[i][j] < dist[i][j + 1] + 1) ? dist[i][j] : dist[i][j + 1] + 1;
                }
            }
        }
    }

    return dist;
}