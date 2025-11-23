#include <stdio.h>
#include <stdlib.h>

int* createArray(int size) {
    return (int*)malloc(size * sizeof(int));
}

int longestArithSeqLen(int* nums, int numsSize, int difference) {
    if (numsSize <= 2) return numsSize;

    int* dp = createArray(numsSize);
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    for (int i = 1; i < numsSize; i++) {
        int target = nums[i] - difference;
        for (int j = 0; j < i; j++) {
            if (nums[j] == target) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
    }

    int maxLen = 1;
    for (int i = 0; i < numsSize; i++) {
        maxLen = fmax(maxLen, dp[i]);
    }

    free(dp);
    return maxLen;
}