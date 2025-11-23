#include <stdio.h>
#include <stdlib.h>

int* longestSubsequence(int* nums, int numsSize, int* group, int groupSize, int* returnSize) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* prev = (int*)malloc(numsSize * sizeof(int));
    int* result = (int*)malloc(numsSize * sizeof(int));
    int maxLen = 0;
    int lastIndex = -1;

    for (int i = 0; i < numsSize; ++i) {
        dp[i] = 1;
        prev[i] = -1;
        for (int j = 0; j < i; ++j) {
            if (group[i] != group[j] && nums[i] != nums[j] && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
                prev[i] = j;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
            lastIndex = i;
        }
    }

    int index = 0;
    while (lastIndex != -1) {
        result[index++] = nums[lastIndex];
        lastIndex = prev[lastIndex];
    }

    *returnSize = index;
    int* reversedResult = (int*)malloc(index * sizeof(int));
    for (int i = 0; i < index; ++i) {
        reversedResult[i] = result[index - 1 - i];
    }

    free(dp);
    free(prev);
    free(result);

    return reversedResult;
}