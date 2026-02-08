#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int paintWalls(int* cost, int costSize, int* time, int timeSize) {
    int n = costSize;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX / 2;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        for (int j = n; j > 0; j--) {
            dp[j] = fmin(dp[j], dp[fmax(0, j - time[i] - 1)] + cost[i]);
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}