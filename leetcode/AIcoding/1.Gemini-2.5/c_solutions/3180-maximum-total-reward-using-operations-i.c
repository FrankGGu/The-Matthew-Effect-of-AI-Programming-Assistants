#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxTotalReward(int* reward, int rewardSize) {
    qsort(reward, rewardSize, sizeof(int), compare);

    const int MAX_REWARD_VALUE = 2000;
    const int MAX_POSSIBLE_SUM = 2 * MAX_REWARD_VALUE; // Max sum is 2*2000-1 = 3999. Array size 4000 covers indices 0-3999.
    bool dp[MAX_POSSIBLE_SUM];
    memset(dp, 0, sizeof(dp));

    dp[0] = true;

    for (int i = 0; i < rewardSize; i++) {
        int r = reward[i];
        for (int s = MAX_POSSIBLE_SUM - 1; s >= 0; s--) {
            if (dp[s] && s < r) {
                if (s + r < MAX_POSSIBLE_SUM) {
                    dp[s + r] = true;
                }
            }
        }
    }

    int max_reward = 0;
    for (int s = MAX_POSSIBLE_SUM - 1; s >= 0; s--) {
        if (dp[s]) {
            max_reward = s;
            break;
        }
    }

    return max_reward;
}