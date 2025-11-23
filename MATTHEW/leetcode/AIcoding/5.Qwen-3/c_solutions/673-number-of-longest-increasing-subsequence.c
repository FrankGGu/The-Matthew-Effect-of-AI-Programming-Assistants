#include <stdio.h>
#include <stdlib.h>

int* lengthOfLIS(int* nums, int numsSize, int* returnSize) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* count = (int*)malloc(numsSize * sizeof(int));
    int maxLen = 0;
    int result = 0;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        count[i] = 1;
        for (int j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    count[i] = count[j];
                } else if (dp[j] + 1 == dp[i]) {
                    count[i] += count[j];
                }
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
            result = count[i];
        } else if (dp[i] == maxLen) {
            result += count[i];
        }
    }

    *returnSize = 1;
    int* res = (int*)malloc(sizeof(int));
    res[0] = result;
    free(dp);
    free(count);
    return res;
}