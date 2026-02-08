#include <stdbool.h>
#include <string.h>

bool canPartition(int* nums, int numsSize) {
    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    if (totalSum % 2 != 0) {
        return false;
    }

    int targetSum = totalSum / 2;

    bool dp[10001]; 
    memset(dp, 0, sizeof(dp));
    dp[0] = true;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int j = targetSum; j >= num; j--) {
            dp[j] = dp[j] || dp[j - num];
        }
    }

    return dp[targetSum];
}