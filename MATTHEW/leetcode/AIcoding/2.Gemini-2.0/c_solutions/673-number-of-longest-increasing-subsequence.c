#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findNumberOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int* dp = (int*)malloc(sizeof(int) * numsSize);
    int* count = (int*)malloc(sizeof(int) * numsSize);

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        count[i] = 1;
    }

    int max_len = 1;
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    count[i] = count[j];
                } else if (dp[j] + 1 == dp[i]) {
                    count[i] += count[j];
                }
            }
        }
        if (dp[i] > max_len) {
            max_len = dp[i];
        }
    }

    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        if (dp[i] == max_len) {
            result += count[i];
        }
    }

    free(dp);
    free(count);

    return result;
}