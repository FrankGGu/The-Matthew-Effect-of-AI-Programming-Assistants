#include <stdio.h>
#include <stdlib.h>

bool canPartition(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum % 2 != 0) return false;
    int target = sum / 2;
    bool* dp = (bool*)malloc((target + 1) * sizeof(bool));
    for (int i = 0; i <= target; i++) {
        dp[i] = false;
    }
    dp[0] = true;
    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            if (dp[j - nums[i]]) {
                dp[j] = true;
            }
        }
    }
    bool result = dp[target];
    free(dp);
    return result;
}