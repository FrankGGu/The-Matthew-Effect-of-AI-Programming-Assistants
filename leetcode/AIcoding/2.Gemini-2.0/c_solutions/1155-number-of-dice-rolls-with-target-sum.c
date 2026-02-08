#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numRollsToTarget(int n, int k, int target) {
    const int MOD = 1000000007;
    int dp[n + 1][target + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= target; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= target; j++) {
            for (int x = 1; x <= k; x++) {
                if (j >= x) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - x]) % MOD;
                }
            }
        }
    }

    return dp[n][target];
}