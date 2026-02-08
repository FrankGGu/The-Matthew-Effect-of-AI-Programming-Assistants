#include <stdio.h>
#include <stdlib.h>

int maxSum(int* nums, int numsSize) {
    int i, j, k;
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    for (i = 0; i < n; i++) {
        dp[i] = nums[i];
    }
    for (i = 1; i < n; i++) {
        for (j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                dp[i] = (dp[i] > dp[j] + nums[i]) ? dp[i] : dp[j] + nums[i];
            }
        }
    }
    int max = dp[0];
    for (i = 1; i < n; i++) {
        if (dp[i] > max) {
            max = dp[i];
        }
    }
    free(dp);
    return max;
}