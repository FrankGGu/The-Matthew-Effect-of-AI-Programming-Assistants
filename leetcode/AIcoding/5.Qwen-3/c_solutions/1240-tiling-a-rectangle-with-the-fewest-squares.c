#include <stdio.h>
#include <stdlib.h>

int tilingRectangle(int n, int m) {
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(m * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            dp[i][j] = i * j;
        }
    }

    for (int i = 1; i < n; i++) {
        for (int j = 1; j < m; j++) {
            for (int k = 0; k < i; k++) {
                dp[i][j] = fmin(dp[i][j], dp[k][j] + dp[i - k - 1][j]);
            }
            for (int k = 0; k < j; k++) {
                dp[i][j] = fmin(dp[i][j], dp[i][k] + dp[i][j - k - 1]);
            }
            if (i >= 2 && j >= 2) {
                for (int k = 1; k <= i / 2; k++) {
                    for (int l = 1; l <= j / 2; l++) {
                        dp[i][j] = fmin(dp[i][j], dp[k][l] + dp[i - k][l] + dp[k][j - l] + dp[i - k][j - l]);
                    }
                }
            }
        }
    }

    int result = dp[n - 1][m - 1];
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}