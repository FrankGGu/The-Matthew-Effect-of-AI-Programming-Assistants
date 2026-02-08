#include <stdbool.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

bool stoneGame(int* piles, int pilesSize) {
    int** dp = (int**)malloc(pilesSize * sizeof(int*));
    for (int i = 0; i < pilesSize; ++i) {
        dp[i] = (int*)malloc(pilesSize * sizeof(int));
    }

    for (int i = 0; i < pilesSize; ++i) {
        dp[i][i] = piles[i];
    }

    for (int len = 2; len <= pilesSize; ++len) {
        for (int i = 0; i <= pilesSize - len; ++i) {
            int j = i + len - 1;
            dp[i][j] = max(piles[i] - dp[i+1][j], piles[j] - dp[i][j-1]);
        }
    }

    bool aliceWins = dp[0][pilesSize - 1] > 0;

    for (int i = 0; i < pilesSize; ++i) {
        free(dp[i]);
    }
    free(dp);

    return aliceWins;
}