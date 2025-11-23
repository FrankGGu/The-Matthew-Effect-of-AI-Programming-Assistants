#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stoneGameVII(int* stones, int stonesSize) {
    int sum = 0;
    for (int i = 0; i < stonesSize; i++) {
        sum += stones[i];
    }

    int dp[stonesSize][stonesSize];

    for (int i = 0; i < stonesSize; i++) {
        dp[i][i] = 0;
    }

    for (int len = 2; len <= stonesSize; len++) {
        for (int i = 0; i <= stonesSize - len; i++) {
            int j = i + len - 1;
            dp[i][j] = fmax(sum - stones[i] - dp[i + 1][j], sum - stones[j] - dp[i][j - 1]);
        }
        sum -= stones[stonesSize - len];
    }

    return dp[0][stonesSize - 1];
}