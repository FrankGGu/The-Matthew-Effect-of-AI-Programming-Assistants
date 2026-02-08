#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxStrength(char** strength, int strengthSize) {
    int n = strengthSize;
    int m = strlen(strength[0]);
    int dp[n][m];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            dp[i][j] = strength[i][j] - '0';
            if (i > 0 && j > 0) {
                dp[i][j] += fmax(dp[i-1][j], dp[i][j-1]);
            } else if (i > 0) {
                dp[i][j] += dp[i-1][j];
            } else if (j > 0) {
                dp[i][j] += dp[i][j-1];
            }
        }
    }
    return dp[n-1][m-1];
}