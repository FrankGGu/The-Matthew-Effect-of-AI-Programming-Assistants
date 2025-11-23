#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canPartition(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum % 2 != 0) {
        return false;
    }
    int target = sum / 2;
    bool dp[target + 1];
    for (int i = 0; i <= target; i++) {
        dp[i] = false;
    }
    dp[0] = true;
    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            dp[j] = dp[j] || dp[j - nums[i]];
        }
    }
    return dp[target];
}