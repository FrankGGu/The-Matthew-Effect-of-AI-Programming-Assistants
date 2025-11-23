#include <stdio.h>
#include <stdlib.h>

int distinctRolls(int n) {
    int dp[1001][7];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= 6; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= 6; j++) {
            for (int k = 1; k <= 6; k++) {
                if (k != j) {
                    dp[i][j] += dp[i - 1][k];
                }
            }
        }
    }
    int result = 0;
    for (int i = 1; i <= 6; i++) {
        result += dp[n][i];
    }
    return result;
}