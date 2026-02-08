#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getSumAbsoluteDifferences(int* nums, int numsSize, int* returnSize){
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));

    int prefixSum[numsSize];
    prefixSum[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefixSum[i] = prefixSum[i - 1] + nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        int leftSum = (i > 0) ? prefixSum[i - 1] : 0;
        int rightSum = prefixSum[numsSize - 1] - prefixSum[i];

        int leftCount = i;
        int rightCount = numsSize - 1 - i;

        int leftDiff = (nums[i] * leftCount) - leftSum;
        int rightDiff = rightSum - (nums[i] * rightCount);

        result[i] = leftDiff + rightDiff;
    }

    return result;
}