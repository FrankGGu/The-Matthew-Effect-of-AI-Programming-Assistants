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
        for (int j = i; j >= 1 && j >= i - k + 1; j--) {
            maxVal = fmax(maxVal, nums[j - 1]);
            if (j - 1 >= 0) {
                if (dp[j - 1] != INT_MAX) {
                    dp[i] = fmin(dp[i], dp[j - 1] + cost);
                }
            }
            cost += maxVal;
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}