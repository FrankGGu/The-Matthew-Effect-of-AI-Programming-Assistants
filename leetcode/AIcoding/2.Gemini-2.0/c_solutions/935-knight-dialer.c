#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int knightDialer(int n) {
    int mod = 1000000007;
    long long dp[n + 1][10];
    int moves[10][5] = {
        {4, 6, -1, -1, -1},
        {6, 8, -1, -1, -1},
        {7, 9, -1, -1, -1},
        {4, 8, -1, -1, -1},
        {0, 3, 9, -1, -1},
        {-1, -1, -1, -1, -1},
        {0, 1, 7, -1, -1},
        {2, 6, -1, -1, -1},
        {1, 3, -1, -1, -1},
        {2, 4, -1, -1, -1}
    };

    for (int i = 0; i < 10; i++) {
        dp[1][i] = 1;
    }

    for (int i = 2; i <= n; i++) {
        for (int j = 0; j < 10; j++) {
            dp[i][j] = 0;
            for (int k = 0; moves[j][k] != -1; k++) {
                dp[i][j] = (dp[i][j] + dp[i - 1][moves[j][k]]) % mod;
            }
        }
    }

    long long total = 0;
    for (int i = 0; i < 10; i++) {
        total = (total + dp[n][i]) % mod;
    }

    return (int)total;
}