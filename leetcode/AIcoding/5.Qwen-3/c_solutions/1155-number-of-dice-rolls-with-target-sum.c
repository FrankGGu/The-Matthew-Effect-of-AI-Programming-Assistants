#include <stdio.h>
#include <stdlib.h>

int numRollsToTarget(int d, int f, int target) {
    int MOD = 1000000007;
    int **dp = (int **)malloc((d + 1) * sizeof(int *));
    for (int i = 0; i <= d; i++) {
        dp[i] = (int *)calloc(target + 1, sizeof(int));
    }

    for (int i = 1; i <= f && i <= target; i++) {
        dp[1][i] = 1;
    }

    for (int i = 2; i <= d; i++) {
        for (int j = 1; j <= target; j++) {
            for (int k = 1; k <= f && j - k >= 0; k++) {
                dp[i][j] += dp[i - 1][j - k];
                dp[i][j] %= MOD;
            }
        }
    }

    int result = dp[d][target];
    for (int i = 0; i <= d; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}