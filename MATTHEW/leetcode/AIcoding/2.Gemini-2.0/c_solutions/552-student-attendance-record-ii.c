#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int checkRecord(int n) {
    const int MOD = 1000000007;
    int dp[n + 1][2][3];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 3; k++) {
                dp[i][j][k] = 0;
            }
        }
    }
    dp[0][0][0] = 1;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 3; k++) {
                dp[i][j][0] = (dp[i][j][0] + dp[i - 1][j][k]) % MOD;
                if (j > 0) {
                    dp[i][j][0] = (dp[i][j][0] + dp[i - 1][j - 1][k]) % MOD;
                }
                if (k > 0) {
                    dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j][k - 1]) % MOD;
                }
            }
        }
    }
    int result = 0;
    for (int j = 0; j < 2; j++) {
        for (int k = 0; k < 3; k++) {
            result = (result + dp[n][j][k]) % MOD;
        }
    }
    return result;
}