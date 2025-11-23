#define MAX_VAL 2000

int maxTotalReward(int* rewardValues, int rewardValuesSize) {
    int maxReward = 0;
    for (int i = 0; i < rewardValuesSize; i++) {
        if (rewardValues[i] > maxReward) {
            maxReward = rewardValues[i];
        }
    }

    int maxSum = 2 * maxReward - 1;
    char* dp = (char*)calloc(maxSum + 1, sizeof(char));
    dp[0] = 1;

    for (int i = 0; i < rewardValuesSize; i++) {
        int current = rewardValues[i];
        for (int j = maxSum - current; j >= 0; j--) {
            if (dp[j] && j + current <= maxSum) {
                dp[j + current] = 1;
            }
        }
    }

    for (int i = maxSum; i >= 0; i--) {
        if (dp[i]) {
            free(dp);
            return i;
        }
    }

    free(dp);
    return 0;
}