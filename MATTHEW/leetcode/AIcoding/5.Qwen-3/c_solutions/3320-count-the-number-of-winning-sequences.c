#include <stdio.h>
#include <stdlib.h>

int countWinningSequences(int n) {
    int dp[101][3][3];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 3; j++) {
            for (int k = 0; k < 3; k++) {
                dp[i][j][k] = 0;
            }
        }
    }
    dp[0][0][0] = 1;
    dp[0][1][1] = 1;
    dp[0][2][2] = 1;
    for (int i = 1; i < n; i++) {
        for (int prev = 0; prev < 3; prev++) {
            for (int curr = 0; curr < 3; curr++) {
                if (prev != curr) {
                    for (int j = 0; j < 3; j++) {
                        dp[i][curr][j] += dp[i - 1][prev][j];
                    }
                }
            }
        }
    }
    int result = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            result += dp[n - 1][i][j];
        }
    }
    return result;
}