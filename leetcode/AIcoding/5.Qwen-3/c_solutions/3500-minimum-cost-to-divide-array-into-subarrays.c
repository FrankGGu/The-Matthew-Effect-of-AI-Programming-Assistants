#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minCost(int* nums, int numsSize, int k) {
    int n = numsSize;
    long long dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = LLONG_MAX;
    }
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        int max_val = nums[i - 1];
        int min_val = nums[i - 1];
        long long cost = 0;
        for (int j = i - 1; j >= 0 && j >= i - k; j--) {
            max_val = fmax(max_val, nums[j]);
            min_val = fmin(min_val, nums[j]);
            cost += max_val - min_val;
            if (dp[j] != LLONG_MAX) {
                dp[i] = fmin(dp[i], dp[j] + cost);
            }
        }
    }

    return dp[n];
}