#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int kInversePairs(int n, int k) {
    const int MOD = 1000000007;
    int dp[n + 1][k + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;
    for (int i = 1; i <= n; i++) {
        dp[i][0] = 1;
        for (int j = 1; j <= k; j++) {
            dp[i][j] = (dp[i][j - 1] + dp[i - 1][j]) % MOD;
            if (j >= i) {
                dp[i][j] = (dp[i][j] - dp[i - 1][j - i] + MOD) % MOD;
            }
        }
    }
    return dp[n][k];
}