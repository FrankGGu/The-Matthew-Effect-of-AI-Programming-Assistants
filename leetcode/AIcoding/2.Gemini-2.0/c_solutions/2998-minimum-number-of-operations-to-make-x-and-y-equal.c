#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int x, int y) {
    if (x >= y) {
        return x - y;
    }

    int dp[10001];
    for (int i = 0; i <= 10000; i++) {
        dp[i] = INT_MAX;
    }

    dp[y] = 0;

    for (int i = y; i <= x + 1000; i++) {
        if (dp[i] == INT_MAX) continue;

        if (i > 0 && dp[i - 1] > dp[i] + 1) {
            dp[i - 1] = dp[i] + 1;
        }
        if (dp[i + 1] > dp[i] + 1) {
            dp[i + 1] = dp[i] + 1;
        }

        if (i % 5 == 0) {
            if (dp[i / 5] > dp[i] + 1) {
                dp[i / 5] = dp[i] + 1;
            }
        } else {
            int rem = i % 5;
            if (dp[i - rem] > dp[i] + rem) {
                dp[i - rem] = dp[i] + rem;
            }
            if (dp[i + (5 - rem)] > dp[i] + (5 - rem)) {
                dp[i + (5 - rem)] = dp[i] + (5 - rem);
            }
        }

        if (i % 11 == 0) {
            if (dp[i / 11] > dp[i] + 1) {
                dp[i / 11] = dp[i] + 1;
            }
        } else {
            int rem = i % 11;
            if (dp[i - rem] > dp[i] + rem) {
                dp[i - rem] = dp[i] + rem;
            }
            if (dp[i + (11 - rem)] > dp[i] + (11 - rem)) {
                dp[i + (11 - rem)] = dp[i] + (11 - rem);
            }
        }
    }

    return dp[x];
}