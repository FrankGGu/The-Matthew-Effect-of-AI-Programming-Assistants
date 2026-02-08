#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minSumKSubarrays(int* nums, int numsSize, int k, int m) {
    int n = numsSize;
    long long total = 0;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; ++i) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 1; i <= n; ++i) {
        for (int j = 0; j < i; ++j) {
            if (i - j >= m) {
                int sum = prefix[i] - prefix[j];
                if (dp[j] != INT_MAX) {
                    dp[i] = (dp[i] < dp[j] + sum) ? dp[i] : dp[j] + sum;
                }
            }
        }
    }

    free(prefix);
    free(dp);
    return dp[n];
}