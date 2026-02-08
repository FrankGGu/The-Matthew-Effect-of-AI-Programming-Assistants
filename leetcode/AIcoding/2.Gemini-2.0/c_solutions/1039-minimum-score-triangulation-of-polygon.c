#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minScoreTriangulation(int* values, int valuesSize) {
    int dp[valuesSize][valuesSize];
    for (int i = 0; i < valuesSize; i++) {
        for (int j = 0; j < valuesSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 3; len <= valuesSize; len++) {
        for (int i = 0; i <= valuesSize - len; i++) {
            int j = i + len - 1;
            dp[i][j] = INT_MAX;
            for (int k = i + 1; k < j; k++) {
                int score = dp[i][k] + dp[k][j] + values[i] * values[k] * values[j];
                if (score < dp[i][j]) {
                    dp[i][j] = score;
                }
            }
        }
    }

    return dp[0][valuesSize - 1];
}