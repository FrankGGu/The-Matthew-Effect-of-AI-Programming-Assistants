#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfSets(int n, int k) {
    long long dp[n + 1][k + 1];
    int mod = 1000000007;

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        dp[i][0] = 1;
    }

    for (int j = 1; j <= k; j++) {
        for (int i = 2 * j; i <= n; i++) {
            dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1] + dp[i - 2][j - 1]) % mod;
        }
    }

    return dp[n][k];
}