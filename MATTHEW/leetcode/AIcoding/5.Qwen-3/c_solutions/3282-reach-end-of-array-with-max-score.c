#include <stdio.h>
#include <stdlib.h>

int maxScore(int* nums, int numsSize) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    dp[0] = nums[0];
    for (int i = 1; i < n; i++) {
        dp[i] = nums[i];
        for (int j = 1; j <= i; j++) {
            if (i - j >= 0) {
                dp[i] = fmax(dp[i], dp[i - j] + nums[i]);
            }
        }
    }
    int result = dp[n - 1];
    free(dp);
    return result;
}