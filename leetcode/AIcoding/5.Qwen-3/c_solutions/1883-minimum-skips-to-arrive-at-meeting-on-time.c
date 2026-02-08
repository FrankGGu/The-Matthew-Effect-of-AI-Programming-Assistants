#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minSkips(int n, int* time, int* dist) {
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i < n; i++) {
        for (int j = 0; j <= i; j++) {
            if (j > 0) {
                if (dp[i - 1][j - 1] != INT_MAX) {
                    dp[i][j] = dp[i - 1][j - 1] + time[i - 1] * dist[i - 1];
                }
            }
            if (dp[i - 1][j] != INT_MAX) {
                dp[i][j] = fmin(dp[i][j], dp[i - 1][j] + time[i - 1] * dist[i - 1]);
            }
        }
    }

    for (int k = 0; k < n; k++) {
        if (dp[n - 1][k] <= time[n - 1] * dist[n - 1]) {
            for (int i = 0; i < n; i++) {
                free(dp[i]);
            }
            free(dp);
            return k;
        }
    }

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    return -1;
}