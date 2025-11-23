#include <stdlib.h> // For malloc and abs

int* leftRigthDifference(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* answer = (int*)malloc(numsSize * sizeof(int));
    if (numsSize == 0) {
        return answer;
    }

    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int leftSum = 0;
    for (int i = 0; i < numsSize; i++) {
        int rightSum = totalSum - leftSum - nums[i];
        answer[i] = abs(leftSum - rightSum);
        leftSum += nums[i];
    }

    return answer;
}