#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxSubArraySum(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    dp[0] = nums[0];
    for (int i = 1; i < n; i++) {
        dp[i] = nums[i];
        for (int j = 1; j <= k && i - j >= 0; j++) {
            dp[i] = max(dp[i], dp[i - j] + nums[i]);
        }
    }
    int result = dp[n - 1];
    free(dp);
    return result;
}

int maxJump(int* nums, int numsSize) {
    return maxSubArraySum(nums, numsSize, 3);
}