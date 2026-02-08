#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDifficulty(int* jobDifficulty, int jobDifficultySize, int d) {
    if (jobDifficultySize < d) {
        return -1;
    }

    int dp[d + 1][jobDifficultySize + 1];

    for (int i = 0; i <= d; i++) {
        for (int j = 0; j <= jobDifficultySize; j++) {
            dp[i][j] = 10000000;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= d; i++) {
        for (int j = i; j <= jobDifficultySize; j++) {
            int max_difficulty = 0;
            for (int k = j; k >= i; k--) {
                if (jobDifficulty[k - 1] > max_difficulty) {
                    max_difficulty = jobDifficulty[k - 1];
                }
                dp[i][j] = (dp[i][j] < dp[i - 1][k - 1] + max_difficulty) ? dp[i][j] : dp[i - 1][k - 1] + max_difficulty;
            }
        }
    }

    return dp[d][jobDifficultySize];
}