#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumWhiteTiles(char * floor, int numCarpets, int carpetLen) {
    int n = strlen(floor);
    int dp[n + 1][numCarpets + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= numCarpets; j++) {
            dp[i][j] = 1001;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= numCarpets; j++) {
            if (j == 0) {
                dp[i][j] = dp[i - 1][j] + (floor[i - 1] - '0');
            } else {
                dp[i][j] = dp[i - 1][j] + (floor[i - 1] - '0');
                dp[i][j] = (dp[i][j] < dp[i - carpetLen][j - 1]) ? dp[i][j] : dp[i - carpetLen][j - 1];
            }
        }
    }

    return dp[n][numCarpets];
}