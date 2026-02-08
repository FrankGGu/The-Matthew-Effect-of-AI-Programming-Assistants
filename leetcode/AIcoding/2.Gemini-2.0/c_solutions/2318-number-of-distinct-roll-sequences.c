#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int distinctRollSequences(int n) {
    if (n == 1) return 6;

    int dp[n + 1][7][7];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 7; j++) {
            for (int k = 0; k < 7; k++) {
                dp[i][j][k] = 0;
            }
        }
    }

    for (int i = 1; i <= 6; i++) {
        dp[2][0][i] = 1;
    }

    for (int i = 3; i <= n; i++) {
        for (int j = 1; j <= 6; j++) {
            for (int k = 1; k <= 6; k++) {
                if (j == k) continue;
                if (__gcd(j, k) != 1) continue;

                for (int l = 1; l <= 6; l++) {
                    if (l == j) continue;
                    dp[i][k][j] = (dp[i][k][j] + dp[i - 1][l][k]) % MOD;
                }
            }
        }
    }

    int ans = 0;
    for (int i = 1; i <= 6; i++) {
        for (int j = 1; j <= 6; j++) {
            ans = (ans + dp[n][i][j]) % MOD;
        }
    }

    return ans;
}