#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getSumAbsoluteDifferences(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* prefix = (int*)malloc((numsSize + 1) * sizeof(int));

    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        int leftSum = prefix[i] - prefix[0];
        int rightSum = prefix[numsSize] - prefix[i + 1];
        int leftCount = i;
        int rightCount = numsSize - i - 1;
        result[i] = (nums[i] * leftCount - leftSum) + (rightSum - nums[i] * rightCount);
    }

    free(prefix);
    return result;
}