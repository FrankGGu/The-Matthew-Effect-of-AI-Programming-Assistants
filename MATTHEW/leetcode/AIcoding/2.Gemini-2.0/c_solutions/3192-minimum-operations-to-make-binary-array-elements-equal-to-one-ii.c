#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize) {
    int dp[numsSize + 1];
    dp[0] = 0;
    dp[1] = (nums[0] == 0);

    for (int i = 2; i <= numsSize; i++) {
        dp[i] = INT_MAX;
        if (nums[i - 1] == 0) {
            dp[i] = dp[i - 1] + 1;
        } else {
            dp[i] = dp[i - 1];
        }
        if (nums[i - 2] == 0 || nums[i - 1] == 0) {
            int cost = (nums[i - 2] == 0) + (nums[i - 1] == 0);
            if (dp[i - 2] != INT_MAX) {
                dp[i] = (dp[i] < dp[i - 2] + cost) ? dp[i] : (dp[i - 2] + cost);
            }
        }
    }

    return dp[numsSize];
}