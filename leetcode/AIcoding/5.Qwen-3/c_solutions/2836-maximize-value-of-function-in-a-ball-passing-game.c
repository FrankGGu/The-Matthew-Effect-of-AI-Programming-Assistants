#include <stdio.h>
#include <stdlib.h>

int maximizeValue(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = nums[i];
    }

    for (int step = 1; step <= k; step++) {
        int* new_dp = (int*)malloc(n * sizeof(int));
        for (int i = 0; i < n; i++) {
            new_dp[i] = dp[i];
            if (i > 0) {
                new_dp[i] = fmax(new_dp[i], dp[i - 1] + nums[i]);
            }
            if (i < n - 1) {
                new_dp[i] = fmax(new_dp[i], dp[i + 1] + nums[i]);
            }
        }
        free(dp);
        dp = new_dp;
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        result = fmax(result, dp[i]);
    }

    free(dp);
    return result;
}