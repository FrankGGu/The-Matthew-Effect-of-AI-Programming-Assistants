#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int longestSquareStreak(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int maxLen = 0;
    int* dp = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        int sqrtVal = (int)sqrt(nums[i]);
        if (sqrtVal * sqrtVal == nums[i]) {
            for (int j = 0; j < i; j++) {
                if (nums[j] == sqrtVal) {
                    dp[i] = dp[j] + 1;
                    break;
                }
            }
        }
        maxLen = (dp[i] > maxLen) ? dp[i] : maxLen;
    }

    free(dp);
    return maxLen < 2 ? -1 : maxLen;
}