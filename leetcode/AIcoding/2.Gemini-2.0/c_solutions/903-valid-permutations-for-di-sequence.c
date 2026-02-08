#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int validPermDISequence(char * s, int sSize){
    int MOD = 1000000007;
    int n = sSize;
    int dp[n + 1][n + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int j = 0; j <= n; j++) {
        dp[0][j] = 1;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= i; j++) {
            if (s[i - 1] == 'D') {
                for (int k = j; k < i; k++) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            } else {
                for (int k = 0; k < j; k++) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            }
        }
    }

    int ans = 0;
    for (int j = 0; j <= n; j++) {
        ans = (ans + dp[n][j]) % MOD;
    }
    return ans;
}