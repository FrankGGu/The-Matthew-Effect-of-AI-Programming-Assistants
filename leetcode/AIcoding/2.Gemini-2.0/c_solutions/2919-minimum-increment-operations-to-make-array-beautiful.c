#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minIncrementOperations(int *nums, int numsSize, int k) {
    long long *dp = (long long *)malloc(sizeof(long long) * (numsSize + 1));
    dp[0] = 0;
    dp[1] = nums[0] > k ? nums[0] - k : 0;
    dp[2] = numsSize > 1 ? (nums[1] > k ? nums[1] - k : 0) : LLONG_MAX;
    if (dp[2] != LLONG_MAX)
        dp[2] = (dp[1] < dp[2] ? dp[1] : dp[2]);
    else
        dp[2] = dp[1];

    for (int i = 3; i <= numsSize; i++) {
        long long op1 = dp[i - 1] + (nums[i - 1] > k ? nums[i - 1] - k : 0);
        long long op2 = dp[i - 2] + (nums[i - 1] > k ? nums[i - 1] - k : 0);
        long long op3 = dp[i - 3] + (nums[i - 1] > k ? nums[i - 1] - k : 0);

        long long minVal = dp[i - 1];
        if (dp[i - 2] < minVal) minVal = dp[i - 2];
        if (dp[i - 3] < minVal) minVal = dp[i - 3];

        long long currentIncrement = 0;
        int max_val = nums[i - 1];
        if (nums[i - 2] > max_val) max_val = nums[i-2];
        if (nums[i - 3] > max_val) max_val = nums[i-3];

        currentIncrement = (max_val > k ? max_val - k : 0);
        dp[i] = minVal + currentIncrement;
    }

    long long ans = dp[numsSize];
    free(dp);
    return ans;
}