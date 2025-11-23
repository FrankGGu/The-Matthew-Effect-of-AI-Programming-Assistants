#include <stdio.h>
#include <stdlib.h>

int minCostToSplit(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        int maxVal = nums[i - 1];
        int cost = 0;
        for (int j = i - 1; j >= 0 && (i - j) <= k; j--) {
            maxVal = (maxVal > nums[j]) ? maxVal : nums[j];
            if (j > 0) {
                cost += dp[j];
            }
            dp[i] = (dp[i] < cost + maxVal) ? dp[i] : cost + maxVal;
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}