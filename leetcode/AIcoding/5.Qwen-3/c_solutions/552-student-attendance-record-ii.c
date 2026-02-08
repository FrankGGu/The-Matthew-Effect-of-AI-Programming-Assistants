#include <stdio.h>
#include <stdlib.h>

int checkRecord(int n) {
    int mod = 1000000007;
    int dp[n+1][2][3];
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
                dp[i][j][k] = dp[i-1][j][k];
                if (k > 0) {
                    dp[i][j][k] += dp[i-1][j][k-1];
                }
                if (j > 0) {
                    dp[i][j][k] += dp[i-1][j-1][2];
                }
                dp[i][j][k] %= mod;
            }
        }
    }
    int result = 0;
    for (int j = 0; j < 2; j++) {
        for (int k = 0; k < 3; k++) {
            result = (result + dp[n][j][k]) % mod;
        }
    }
    return result;
}