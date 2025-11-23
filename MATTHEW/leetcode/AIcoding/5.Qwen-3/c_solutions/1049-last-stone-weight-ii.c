#include <stdio.h>
#include <stdlib.h>

int lastStoneWeightII(int* stones, int stonesSize) {
    int sum = 0;
    for (int i = 0; i < stonesSize; i++) {
        sum += stones[i];
    }

    int target = sum / 2;
    int* dp = (int*)calloc(target + 1, sizeof(int));

    for (int i = 0; i < stonesSize; i++) {
        for (int j = target; j >= stones[i]; j--) {
            dp[j] = (dp[j] > dp[j - stones[i]] + stones[i]) ? dp[j] : dp[j - stones[i]] + stones[i];
        }
    }

    int max = dp[target];
    free(dp);
    return sum - 2 * max;
}