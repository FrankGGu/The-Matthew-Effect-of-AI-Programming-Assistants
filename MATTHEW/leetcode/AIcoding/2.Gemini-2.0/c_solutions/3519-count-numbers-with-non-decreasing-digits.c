#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dp[11][11];

int solve(int n, int prev) {
    if (n == 0) {
        return 1;
    }
    if (dp[n][prev] != -1) {
        return dp[n][prev];
    }
    int count = 0;
    for (int i = prev; i <= 9; i++) {
        count += solve(n - 1, i);
    }
    return dp[n][prev] = count;
}

int countNumbersWithUniqueDigits(int n) {
    if (n == 0) {
        return 1;
    }
    if (n > 10) {
        n = 10;
    }
    for (int i = 0; i <= 10; i++) {
        for (int j = 0; j <= 10; j++) {
            dp[i][j] = -1;
        }
    }
    return solve(n, 0);
}