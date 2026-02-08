#include <stdio.h>
#include <stdlib.h>

int maximumJumps(int* nums, int numsSize) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        if (dp[i] == -1) continue;
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] != nums[j]) {
                dp[j] = (dp[j] == -1) ? dp[i] + 1 : (dp[j] > dp[i] + 1 ? dp[j] : dp[i] + 1);
            }
        }
    }

    int result = dp[numsSize - 1];
    free(dp);
    return result;
}