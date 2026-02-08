#include <stdio.h>
#include <stdlib.h>

int kthLargestValue(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    int* result = (int*)malloc(rows * cols * sizeof(int));
    int index = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (i == 0 && j == 0) {
                dp[i][j] = matrix[i][j];
            } else if (i == 0) {
                dp[i][j] = dp[i][j - 1] ^ matrix[i][j];
            } else if (j == 0) {
                dp[i][j] = dp[i - 1][j] ^ matrix[i][j];
            } else {
                dp[i][j] = dp[i - 1][j] ^ dp[i][j - 1] ^ matrix[i][j];
            }
            result[index++] = dp[i][j];
        }
    }

    for (int i = 0; i < index - 1; i++) {
        for (int j = i + 1; j < index; j++) {
            if (result[i] < result[j]) {
                int temp = result[i];
                result[i] = result[j];
                result[j] = temp;
            }
        }
    }

    int res = result[k - 1];

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);
    free(result);

    return res;
}