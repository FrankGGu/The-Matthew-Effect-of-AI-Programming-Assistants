#include <stdio.h>
#include <stdlib.h>

int maxBalancedSubsequenceSum(int* nums, int numsSize) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    int* a = (int*)malloc(n * sizeof(int));
    int* b = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        a[i] = nums[i];
        b[i] = i;
    }

    for (int i = 0; i < n; ++i) {
        dp[i] = nums[i];
    }

    for (int i = 1; i < n; ++i) {
        for (int j = 0; j < i; ++j) {
            if (abs(a[i] - a[j]) == abs(b[i] - b[j])) {
                if (dp[j] + nums[i] > dp[i]) {
                    dp[i] = dp[j] + nums[i];
                }
            }
        }
    }

    int max = dp[0];
    for (int i = 1; i < n; ++i) {
        if (dp[i] > max) {
            max = dp[i];
        }
    }

    free(dp);
    free(a);
    free(b);
    return max;
}