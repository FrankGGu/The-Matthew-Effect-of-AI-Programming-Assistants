#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stoneGameII(int* piles, int pilesSize) {
    int sum = 0;
    for (int i = 0; i < pilesSize; i++) {
        sum += piles[i];
    }

    int dp[pilesSize][pilesSize + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = pilesSize - 1; i >= 0; i--) {
        for (int M = 1; M <= pilesSize; M++) {
            int max_score = 0;
            int current_sum = 0;
            for (int x = 1; x <= 2 * M && i + x <= pilesSize; x++) {
                current_sum += piles[i + x - 1];
                if (i + x == pilesSize) {
                    max_score = current_sum;
                } else {
                    int next_M = (x > M) ? x : M;
                    int opponent_score = dp[i + x][next_M];
                    int current_score = current_sum + (sum - current_sum - opponent_score);
                    if (x == 1 || current_score > max_score) {
                        max_score = current_score;
                    }
                }
            }
            dp[i][M] = max_score;
        }
    }

    return dp[0][1];
}