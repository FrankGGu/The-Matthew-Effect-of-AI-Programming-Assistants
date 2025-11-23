#include <stdio.h>
#include <stdlib.h>

int minScoreTriangulation(int* values, int valuesSize) {
    int n = valuesSize;
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int length = 2; length < n; length++) {
        for (int i = 0; i < n - length; i++) {
            int j = i + length;
            dp[i][j] = INT_MAX;
            for (int k = i + 1; k < j; k++) {
                int score = dp[i][k] + dp[k][j] + values[i] * values[k] * values[j];
                if (score < dp[i][j]) {
                    dp[i][j] = score;
                }
            }
        }
    }

    int result = dp[0][n - 1];

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}