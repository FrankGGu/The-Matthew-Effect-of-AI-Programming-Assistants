#include <stdio.h>
#include <stdlib.h>

int maxAlternatingSubarrays(int* nums, int numsSize) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    int* prev = (int*)malloc(n * sizeof(int));
    int maxCost = 0;

    for (int i = 0; i < n; i++) {
        dp[i] = 1;
        prev[i] = -1;
    }

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if ((nums[j] > nums[j + 1] && nums[i - 1] > nums[i]) || (nums[j] < nums[j + 1] && nums[i - 1] < nums[i])) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        maxCost = (dp[i] > maxCost) ? dp[i] : maxCost;
    }

    free(dp);
    free(prev);
    return maxCost;
}