#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximalSquare(char** matrix, int matrixRowSize, int matrixColSize) {
    if (matrix == NULL || matrixRowSize == 0 || matrixColSize == 0) return 0;

    int** dp = (int**)malloc(matrixRowSize * sizeof(int*));
    for (int i = 0; i < matrixRowSize; i++) {
        dp[i] = (int*)malloc(matrixColSize * sizeof(int));
    }

    int maxSide = 0;

    for (int i = 0; i < matrixRowSize; i++) {
        for (int j = 0; j < matrixColSize; j++) {
            if (matrix[i][j] == '1') {
                if (i == 0 || j == 0) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = fmin(fmin(dp[i-1][j], dp[i][j-1]), dp[i-1][j-1]) + 1;
                }
                maxSide = fmax(maxSide, dp[i][j]);
            } else {
                dp[i][j] = 0;
            }
        }
    }

    for (int i = 0; i < matrixRowSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxSide * maxSide;
}