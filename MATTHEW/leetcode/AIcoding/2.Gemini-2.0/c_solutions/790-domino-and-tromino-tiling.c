#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numTilings(int n){
    int MOD = 1000000007;
    if (n == 1) return 1;
    if (n == 2) return 2;
    if (n == 3) return 5;

    long long dp[n + 1];
    dp[0] = 0;
    dp[1] = 1;
    dp[2] = 2;
    dp[3] = 5;

    for (int i = 4; i <= n; i++) {
        dp[i] = (2 * dp[i - 1] % MOD + dp[i - 3] % MOD) % MOD;
    }

    return (int)dp[n];
}