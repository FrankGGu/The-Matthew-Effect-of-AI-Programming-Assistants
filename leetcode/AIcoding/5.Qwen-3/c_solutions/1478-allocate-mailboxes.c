#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minCost(int* houses, int housesSize, int k, int* cost) {
    int n = housesSize;
    int** dp = (int**)malloc(sizeof(int*) * (n + 1));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc(sizeof(int) * (k + 1));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int i = 0; i <= n; i++) {
        dp[i][0] = 0;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            for (int m = 0; m < i; m++) {
                if (dp[m][j - 1] != INT_MAX) {
                    int costToMakeSame = 0;
                    for (int p = m; p < i; p++) {
                        costToMakeSame += abs(houses[p] - houses[m]);
                    }
                    dp[i][j] = fmin(dp[i][j], dp[m][j - 1] + costToMakeSame);
                }
            }
        }
    }

    int result = dp[n][k];
    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}