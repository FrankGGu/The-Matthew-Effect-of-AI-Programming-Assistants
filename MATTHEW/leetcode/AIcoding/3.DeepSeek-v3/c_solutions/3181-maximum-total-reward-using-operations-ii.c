#include <stdlib.h>
#include <string.h>

#define MAX_REWARD 2000

int maxTotalReward(int* rewardValues, int rewardValuesSize) {
    int maxVal = 0;
    for (int i = 0; i < rewardValuesSize; i++) {
        if (rewardValues[i] > maxVal) {
            maxVal = rewardValues[i];
        }
    }

    int limit = 2 * maxVal;
    if (limit > MAX_REWARD * 2) {
        limit = MAX_REWARD * 2;
    }

    char* dp = (char*)calloc(limit + 1, sizeof(char));
    dp[0] = 1;

    qsort(rewardValues, rewardValuesSize, sizeof(int), (int(*)(const void*, const void*))strcmp);

    for (int i = 0; i < rewardValuesSize; i++) {
        int r = rewardValues[i];
        for (int j = limit - 1; j >= 0; j--) {
            if (dp[j] && j < r) {
                if (j + r < limit) {
                    dp[j + r] = 1;
                }
            }
        }
    }

    int result = 0;
    for (int i = limit - 1; i >= 0; i--) {
        if (dp[i]) {
            result = i;
            break;
        }
    }

    free(dp);
    return result;
}