#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long findMaxArrayValue(int* nums, int numsSize) {
    long long dp[numsSize];
    dp[0] = nums[0];
    long long ans = dp[0];

    for (int i = 1; i < numsSize; i++) {
        dp[i] = max(nums[i], dp[i - 1] + nums[i]);
        ans = max(ans, dp[i]);
    }
    return ans;
}