#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFallingPathSum(int** matrix, int matrixSize, int* matrixColSize){
    int n = matrixSize;
    int m = matrixColSize[0];

    int dp[n][m];

    for (int j = 0; j < m; j++) {
        dp[0][j] = matrix[0][j];
    }

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int min_val = dp[i - 1][j];
            if (j > 0) {
                min_val = (min_val < dp[i - 1][j - 1]) ? min_val : dp[i - 1][j - 1];
            }
            if (j < m - 1) {
                min_val = (min_val < dp[i - 1][j + 1]) ? min_val : dp[i - 1][j + 1];
            }
            dp[i][j] = matrix[i][j] + min_val;
        }
    }

    int min_sum = dp[n - 1][0];
    for (int j = 1; j < m; j++) {
        min_sum = (min_sum < dp[n - 1][j]) ? min_sum : dp[n - 1][j];
    }

    return min_sum;
}