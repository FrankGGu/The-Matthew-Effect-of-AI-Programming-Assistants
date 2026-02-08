#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFallingPathSum(int** arr, int arrSize, int* arrColSize){
    int n = arrSize;
    int m = arrColSize[0];

    int dp[n][m];

    for (int j = 0; j < m; j++) {
        dp[0][j] = arr[0][j];
    }

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < m; j++) {
            dp[i][j] = INT_MAX;
            for (int k = 0; k < m; k++) {
                if (k != j) {
                    dp[i][j] = fmin(dp[i][j], dp[i - 1][k] + arr[i][j]);
                }
            }
        }
    }

    int minSum = INT_MAX;
    for (int j = 0; j < m; j++) {
        minSum = fmin(minSum, dp[n - 1][j]);
    }

    return minSum;
}