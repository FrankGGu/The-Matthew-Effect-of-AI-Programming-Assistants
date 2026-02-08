#include <stdio.h>
#include <stdlib.h>

int minCostToDivideArray(int* nums, int numsSize) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    int* prefix = (int*)malloc(n * sizeof(int));

    prefix[0] = nums[0];
    for (int i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    for (int i = 0; i < n; i++) {
        dp[i] = INT_MAX;
        for (int j = 0; j < i; j++) {
            if (prefix[i] - prefix[j] >= 0) {
                dp[i] = fmin(dp[i], dp[j] + prefix[i] - prefix[j]);
            }
        }
    }

    int result = dp[n - 1];
    free(dp);
    free(prefix);
    return result;
}