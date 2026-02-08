#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int** updateMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 0) {
                dist[i][j] = 0;
            } else {
                dist[i][j] = INT_MAX;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 0) {
                continue;
            }
            int minDist = INT_MAX;
            if (i > 0 && dist[i - 1][j] != INT_MAX) {
                minDist = dist[i - 1][j] + 1;
            }
            if (j > 0 && dist[i][j - 1] != INT_MAX) {
                minDist = (minDist < dist[i][j - 1] + 1) ? minDist : dist[i][j - 1] + 1;
            }
            if (minDist != INT_MAX) {
                dist[i][j] = minDist;
            }
        }
    }

    for (int i = m - 1; i >= 0; i--) {
        for (int j = n - 1; j >= 0; j--) {
            if (matrix[i][j] == 0) {
                continue;
            }
            int minDist = INT_MAX;
            if (i < m - 1 && dist[i + 1][j] != INT_MAX) {
                minDist = dist[i + 1][j] + 1;
            }
            if (j < n - 1 && dist[i][j + 1] != INT_MAX) {
                minDist = (minDist < dist[i][j + 1] + 1) ? minDist : dist[i][j + 1] + 1;
            }
            if (minDist != INT_MAX) {
                dist[i][j] = (dist[i][j] < minDist) ? dist[i][j] : minDist;
            }
        }
    }

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    return dist;
}