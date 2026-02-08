#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int superEggDrop(int k, int n) {
    int dp[k + 1][n + 1];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    int m = 0;
    while (dp[k][m] < n) {
        m++;
        for (int i = 1; i <= k; i++) {
            dp[i][m] = dp[i - 1][m - 1] + dp[i][m - 1] + 1;
        }
    }
    return m;
}