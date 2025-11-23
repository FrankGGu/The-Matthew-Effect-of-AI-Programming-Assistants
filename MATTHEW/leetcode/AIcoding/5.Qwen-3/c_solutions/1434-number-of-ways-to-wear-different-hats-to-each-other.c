#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfWays(char** hats, int hatsSize) {
    int n = hatsSize;
    int hat_to_person[41][n];
    int hat_count[41] = {0};

    for (int i = 0; i < n; ++i) {
        for (int j = 0; hats[i][j]; ++j) {
            int h = hats[i][j] - '0';
            hat_to_person[h][hat_count[h]++] = i;
        }
    }

    int dp[1 << n];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int h = 1; h <= 40; ++h) {
        for (int mask = (1 << n) - 1; mask >= 0; --mask) {
            for (int k = 0; k < hat_count[h]; ++k) {
                int person = hat_to_person[h][k];
                if ((mask & (1 << person)) == 0) {
                    dp[mask | (1 << person)] += dp[mask];
                }
            }
        }
    }

    return dp[(1 << n) - 1];
}