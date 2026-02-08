#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int* largestDivisibleSubset(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(nums, numsSize, sizeof(int), cmp);
    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* pre = (int*)malloc(numsSize * sizeof(int));
    int maxSize = 0, maxIndex = 0;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        pre[i] = -1;
        for (int j = 0; j < i; j++) {
            if (nums[i] % nums[j] == 0 && dp[i] < dp[j] + 1) {
                dp[i] = dp[j] + 1;
                pre[i] = j;
            }
        }
        if (dp[i] > maxSize) {
            maxSize = dp[i];
            maxIndex = i;
        }
    }

    int* result = (int*)malloc(maxSize * sizeof(int));
    *returnSize = maxSize;
    for (int i = maxSize - 1; i >= 0; i--) {
        result[i] = nums[maxIndex];
        maxIndex = pre[maxIndex];
    }

    free(dp);
    free(pre);
    return result;
}