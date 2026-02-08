#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool winnerSquareGame(int n) {
    bool dp[n + 1];
    memset(dp, false, sizeof(dp));

    for (int i = 1; i <= n; i++) {
        for (int k = 1; k * k <= i; k++) {
            if (!dp[i - k * k]) {
                dp[i] = true;
                break;
            }
        }
    }

    return dp[n];
}