#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int numRollsToTarget(int n, int k, int target) {
    int MOD = 1000000007;
    int* dp = (int*)malloc((target + 1) * sizeof(int));
    int* prev = (int*)malloc((target + 1) * sizeof(int));

    for (int i = 1; i <= k && i <= target; i++) {
        prev[i] = 1;
    }

    for (int i = 2; i <= n; i++) {
        for (int t = 1; t <= target; t++) {
            dp[t] = 0;
            for (int j = 1; j <= k && t - j >= 0; j++) {
                dp[t] = (dp[t] + prev[t - j]) % MOD;
            }
        }
        int* temp = prev;
        prev = dp;
        dp = temp;
    }

    int result = prev[target];
    free(dp);
    free(prev);
    return result;
}