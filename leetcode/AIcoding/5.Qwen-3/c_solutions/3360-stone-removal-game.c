#include <stdio.h>
#include <stdlib.h>

int stoneGameVII(int* stones, int stonesSize) {
    int n = stonesSize;
    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        dp[i] = 0;
    }

    for (int length = 2; length <= n; ++length) {
        for (int i = 0; i <= n - length; ++i) {
            int j = i + length - 1;
            dp[i] = (stones[i] - stones[j]) + dp[i + 1];
            if (i > 0) {
                dp[i] = (dp[i] > dp[i - 1]) ? dp[i] : dp[i - 1];
            }
        }
    }

    int result = dp[0];
    free(dp);
    return result;
}