#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lastStoneWeightII(int* stones, int stonesSize) {
    int sum = 0;
    for (int i = 0; i < stonesSize; i++) {
        sum += stones[i];
    }
    int target = sum / 2;

    bool* dp = (bool*)malloc((target + 1) * sizeof(bool));
    for (int i = 0; i <= target; i++) {
        dp[i] = false;
    }
    dp[0] = true;

    for (int i = 0; i < stonesSize; i++) {
        for (int j = target; j >= stones[i]; j--) {
            dp[j] = dp[j] || dp[j - stones[i]];
        }
    }

    int maxWeight = 0;
    for (int i = target; i >= 0; i--) {
        if (dp[i]) {
            maxWeight = i;
            break;
        }
    }

    free(dp);
    return sum - 2 * maxWeight;
}