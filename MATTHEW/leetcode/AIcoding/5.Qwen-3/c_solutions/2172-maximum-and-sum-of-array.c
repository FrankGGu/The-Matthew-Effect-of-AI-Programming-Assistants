#include <stdio.h>
#include <stdlib.h>

int maxAndSum(int* nums, int numsSize) {
    int n = numsSize;
    int dp[1 << n];
    for (int i = 0; i < (1 << n); i++) {
        dp[i] = 0;
    }

    for (int mask = 1; mask < (1 << n); mask++) {
        int bit = __builtin_ctz(mask);
        int prev_mask = mask ^ (1 << bit);
        dp[mask] = dp[prev_mask] + (nums[bit] & nums[prev_mask]);
    }

    return dp[(1 << n) - 1];
}