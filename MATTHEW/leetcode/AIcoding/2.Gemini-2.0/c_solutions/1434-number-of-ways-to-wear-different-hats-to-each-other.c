#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberWays(int **hats, int hatsSize, int *hatsColSize) {
    long long MOD = 1000000007;
    int n = hatsSize;
    int maxHat = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < hatsColSize[i]; j++) {
            if (hats[i][j] > maxHat) {
                maxHat = hats[i][j];
            }
        }
    }

    int hatToPeople[maxHat + 1][n + 1];
    int hatToPeopleSizes[maxHat + 1];
    for (int i = 0; i <= maxHat; i++) {
        hatToPeopleSizes[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < hatsColSize[i]; j++) {
            int hat = hats[i][j];
            hatToPeople[hat][hatToPeopleSizes[hat]++] = i;
        }
    }

    long long dp[maxHat + 1][1 << n];
    for (int i = 0; i <= maxHat; i++) {
        for (int j = 0; j < (1 << n); j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;

    for (int i = 1; i <= maxHat; i++) {
        for (int mask = 0; mask < (1 << n); mask++) {
            dp[i][mask] = (dp[i][mask] + dp[i - 1][mask]) % MOD;
            for (int j = 0; j < hatToPeopleSizes[i]; j++) {
                int person = hatToPeople[i][j];
                if ((mask & (1 << person)) != 0) {
                    dp[i][mask] = (dp[i][mask] + dp[i - 1][mask ^ (1 << person)]) % MOD;
                }
            }
        }
    }

    return (int)dp[maxHat][(1 << n) - 1];
}