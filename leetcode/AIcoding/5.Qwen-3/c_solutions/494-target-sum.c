#include <stdio.h>
#include <stdlib.h>

int findTargetSumWays(int* nums, int numsSize, int target) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    if (abs(target) > sum || (sum + target) % 2 != 0) {
        return 0;
    }

    int newTarget = (sum + target) / 2;

    int* dp = (int*)malloc((newTarget + 1) * sizeof(int));
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = newTarget; j >= nums[i]; j--) {
            dp[j] += dp[j - nums[i]];
        }
    }

    int result = dp[newTarget];
    free(dp);
    return result;
}