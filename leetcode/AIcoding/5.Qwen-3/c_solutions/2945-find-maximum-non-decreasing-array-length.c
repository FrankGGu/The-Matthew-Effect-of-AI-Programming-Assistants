#include <stdio.h>
#include <stdlib.h>

int maxSubarrayLength(int* nums, int numsSize) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    int maxLen = 1;
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (nums[j] <= nums[i] && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }
    free(dp);
    return maxLen;
}