#include <stdio.h>
#include <stdlib.h>

int stoneGame(int* piles, int pilesSize) {
    int n = pilesSize;
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = piles[i];
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            dp[i][j] = fmax(piles[i] - dp[i + 1][j], piles[j] - dp[i][j - 1]);
        }
    }

    int result = dp[0][n - 1];
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}