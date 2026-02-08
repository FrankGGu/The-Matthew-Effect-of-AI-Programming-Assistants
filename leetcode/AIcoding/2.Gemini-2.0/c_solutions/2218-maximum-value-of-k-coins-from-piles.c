#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxValueOfCoins(int** piles, int pilesSize, int* pilesColSize, int k) {
    int dp[k + 1];
    for (int i = 0; i <= k; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < pilesSize; i++) {
        int temp[k + 1];
        for (int j = 0; j <= k; j++) {
            temp[j] = dp[j];
        }

        for (int j = 0; j < pilesColSize[i]; j++) {
            for (int x = k; x >= j + 1; x--) {
                dp[x] = (dp[x] > temp[x - (j + 1)] + piles[i][j]) ? dp[x] : (temp[x - (j + 1)] + piles[i][j]);
            }
        }
    }

    return dp[k];
}