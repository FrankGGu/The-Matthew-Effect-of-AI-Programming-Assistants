#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxIncreasingCells(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int maxVal = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] > maxVal) {
                maxVal = matrix[i][j];
            }
        }
    }

    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    int** cellValues = (int**)malloc(maxVal * sizeof(int*));
    for (int i = 0; i < maxVal; i++) {
        cellValues[i] = (int*)malloc(2 * sizeof(int));
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            cellValues[count][0] = matrix[i][j];
            cellValues[count][1] = i;
            count++;
        }
    }

    qsort(cellValues, count, sizeof(int*), cmpfunc);

    for (int k = 0; k < count; k++) {
        int val = cellValues[k][0];
        int i = cellValues[k][1];
        int j = cellValues[k][1];

        int max = 0;
        if (i > 0 && matrix[i - 1][j] < val) {
            max = (dp[i - 1][j] > max) ? dp[i - 1][j] : max;
        }
        if (i < rows - 1 && matrix[i + 1][j] < val) {
            max = (dp[i + 1][j] > max) ? dp[i + 1][j] : max;
        }
        if (j > 0 && matrix[i][j - 1] < val) {
            max = (dp[i][j - 1] > max) ? dp[i][j - 1] : max;
        }
        if (j < cols - 1 && matrix[i][j + 1] < val) {
            max = (dp[i][j + 1] > max) ? dp[i][j + 1] : max;
        }
        dp[i][j] = max + 1;
    }

    int result = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (dp[i][j] > result) {
                result = dp[i][j];
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    for (int i = 0; i < maxVal; i++) {
        free(cellValues[i]);
    }
    free(cellValues);

    return result;
}