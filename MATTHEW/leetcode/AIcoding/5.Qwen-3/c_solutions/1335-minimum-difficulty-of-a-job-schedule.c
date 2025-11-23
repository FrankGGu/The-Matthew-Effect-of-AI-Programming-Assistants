#include <stdio.h>
#include <stdlib.h>

int minDifficulty(int* jobDifficulty, int jobDifficultySize, int d) {
    if (jobDifficultySize < d) return -1;

    int** dp = (int**)malloc(sizeof(int*) * (d + 1));
    for (int i = 0; i <= d; i++) {
        dp[i] = (int*)malloc(sizeof(int) * jobDifficultySize);
    }

    for (int i = 0; i < jobDifficultySize; i++) {
        dp[1][i] = jobDifficulty[i];
    }

    for (int i = 2; i <= d; i++) {
        for (int j = i - 1; j < jobDifficultySize; j++) {
            int max_diff = jobDifficulty[j];
            dp[i][j] = INT_MAX;
            for (int k = j - 1; k >= i - 2; k--) {
                max_diff = (max_diff > jobDifficulty[k]) ? max_diff : jobDifficulty[k];
                dp[i][j] = (dp[i][j] < dp[i - 1][k] + max_diff) ? dp[i][j] : dp[i - 1][k] + max_diff;
            }
        }
    }

    int result = dp[d][jobDifficultySize - 1];

    for (int i = 0; i <= d; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}