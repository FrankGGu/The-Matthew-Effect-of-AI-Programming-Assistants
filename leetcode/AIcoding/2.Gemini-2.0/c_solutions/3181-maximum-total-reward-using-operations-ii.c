#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumTotalReward(int* reward, int rewardSize, int k) {
    int n = rewardSize;
    int* dp = (int*)malloc((k + 1) * sizeof(int));
    for (int i = 0; i <= k; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int* new_dp = (int*)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; j++) {
            new_dp[j] = dp[j];
            if (j > 0) {
                int prev_reward = (i > 0) ? reward[i - 1] : 0;
                int current_reward = reward[i];
                new_dp[j] = (new_dp[j] > dp[j - 1] + current_reward) ? new_dp[j] : dp[j - 1] + current_reward;
            }
        }
        free(dp);
        dp = new_dp;
    }

    int result = dp[k];
    free(dp);
    return result;
}