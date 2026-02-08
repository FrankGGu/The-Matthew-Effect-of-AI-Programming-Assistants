#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSum(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    if (k >= numsSize) {
        return 0;
    }

    int *dp = (int *)malloc(sizeof(int) * (numsSize + 1));
    dp[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        dp[i] = dp[i - 1] + nums[i - 1];
    }

    int min_sum = sum;

    for (int i = 0; i <= numsSize - k; i++) {
        int current_sum = dp[i + k] - dp[i];
        int remaining_sum = sum - current_sum;
        if (remaining_sum < min_sum) {
            min_sum = remaining_sum;
        }
    }

    free(dp);
    return min_sum;
}