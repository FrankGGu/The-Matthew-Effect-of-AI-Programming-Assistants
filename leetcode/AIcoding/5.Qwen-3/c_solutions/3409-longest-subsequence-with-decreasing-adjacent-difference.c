#include <stdio.h>
#include <stdlib.h>

int* longestSubsequence(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* prev = (int*)malloc(numsSize * sizeof(int));
    int maxLen = 1;
    int lastIndex = 0;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        prev[i] = -1;
        for (int j = 0; j < i; j++) {
            if (nums[i] < nums[j] && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
                prev[i] = j;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
            lastIndex = i;
        }
    }

    int index = maxLen - 1;
    for (int i = lastIndex; i != -1; i = prev[i]) {
        result[index--] = nums[i];
    }

    *returnSize = maxLen;
    free(dp);
    free(prev);
    return result;
}