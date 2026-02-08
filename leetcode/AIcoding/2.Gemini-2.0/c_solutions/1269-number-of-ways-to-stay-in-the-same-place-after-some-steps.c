#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int numWays(int steps, int arrLen) {
    int max_pos = (steps / 2) + 1;
    if (arrLen < max_pos) {
        max_pos = arrLen;
    }

    int** dp = (int**)malloc((steps + 1) * sizeof(int*));
    for (int i = 0; i <= steps; i++) {
        dp[i] = (int*)malloc(max_pos * sizeof(int));
        for (int j = 0; j < max_pos; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= steps; i++) {
        for (int j = 0; j < max_pos; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j > 0) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
            }
            if (j < max_pos - 1) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD;
            }
        }
    }

    int result = dp[steps][0];

    for (int i = 0; i <= steps; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}