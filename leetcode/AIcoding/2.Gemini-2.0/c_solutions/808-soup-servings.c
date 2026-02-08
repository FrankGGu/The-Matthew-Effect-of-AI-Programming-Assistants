#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double soupServings(int n) {
    if (n >= 4800) return 1.0;
    double dp[n + 1][n + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0.0;
        }
    }
    dp[0][0] = 0.5;
    for (int i = 1; i <= n; i++) {
        dp[i][0] = 1.0;
        dp[0][i] = 0.0;
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            dp[i][j] = 0.25 * (dp[fmax(0, i - 10)][j] + dp[fmax(0, i - 7)][fmax(0, j - 3)] + dp[fmax(0, i - 4)][fmax(0, j - 6)] + dp[fmax(0, i - 1)][fmax(0, j - 7)]);
        }
    }
    return dp[n][n];
}