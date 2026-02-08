#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countArrays(int n, int k, int p) {
    long long dp[n + 1][k + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    dp[1][0] = p - 1;

    for (int i = 2; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            if (j == 0) {
                dp[i][j] = (dp[i - 1][j] * (p - 1)) % MOD;
            } else {
                dp[i][j] = (dp[i - 1][j] * (p - 2)) % MOD;
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
            }
        }
    }

    return (int)dp[n][k];
}