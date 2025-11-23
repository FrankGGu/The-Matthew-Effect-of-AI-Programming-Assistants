#include <stdlib.h>

static int min3(int a, int b, int c) {
    int res = a;
    if (b < res) res = b;
    if (c < res) res = c;
    return res;
}

int maximalSquare(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        return 0;
    }

    int m = matrixSize;
    int n = *matrixColSize;

    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    int maxSide = 0;

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (matrix[i][j] == '1') {
                if (i == 0 || j == 0) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = 1 + min3(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]);
                }
                if (dp[i][j] > maxSide) {
                    maxSide = dp[i][j];
                }
            } else {
                dp[i][j] = 0;
            }
        }
    }

    int result = maxSide * maxSide;

    for (int i = 0; i < m; ++i) {
        free(dp[i]);
    }
    free(dp);

    return result;
}