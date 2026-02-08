#include <stdio.h>
#include <stdlib.h>

long long countArrays(int n, int k) {
    int MOD = 1000000007;
    long long dp[2][n + 1];
    for (int i = 0; i <= n; i++) {
        dp[0][i] = 0;
        dp[1][i] = 0;
    }
    dp[0][1] = 1;
    for (int i = 2; i <= n; i++) {
        dp[0][i] = (dp[0][i - 1] * (k + 1)) % MOD;
        dp[1][i] = (dp[0][i - 1] + dp[1][i - 1] * (k)) % MOD;
    }
    return (dp[0][n] + dp[1][n]) % MOD;
}