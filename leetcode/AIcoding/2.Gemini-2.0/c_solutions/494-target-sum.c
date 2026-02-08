#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTargetSumWays(int* nums, int numsSize, int target) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (abs(target) > sum) {
        return 0;
    }
    if ((sum + target) % 2 != 0) {
        return 0;
    }
    int newTarget = (sum + target) / 2;
    int dp[newTarget + 1];
    for (int i = 0; i <= newTarget; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;
    for (int i = 0; i < numsSize; i++) {
        for (int j = newTarget; j >= nums[i]; j--) {
            dp[j] += dp[j - nums[i]];
        }
    }
    return dp[newTarget];
}