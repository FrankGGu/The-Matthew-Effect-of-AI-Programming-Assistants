#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* largestDivisibleSubset(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int** dp = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = (int*)malloc(sizeof(int) * 2);
        dp[i][0] = 1; // size of subset ending at i
        dp[i][1] = -1; // previous index
    }

    int maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] % nums[j] == 0 && dp[j][0] + 1 > dp[i][0]) {
                dp[i][0] = dp[j][0] + 1;
                dp[i][1] = j;
            }
        }
        if (dp[i][0] > dp[maxIndex][0]) {
            maxIndex = i;
        }
    }

    int size = dp[maxIndex][0];
    *returnSize = size;
    int* result = (int*)malloc(size * sizeof(int));
    int index = size - 1;
    while (maxIndex != -1) {
        result[index--] = nums[maxIndex];
        maxIndex = dp[maxIndex][1];
    }

    for (int i = 0; i < numsSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}