/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* leftRightDifference(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* answer = (int*)malloc(numsSize * sizeof(int));
    int* leftSum = (int*)malloc(numsSize * sizeof(int));
    int* rightSum = (int*)malloc(numsSize * sizeof(int));

    leftSum[0] = 0;
    for (int i = 1; i < numsSize; i++) {
        leftSum[i] = leftSum[i-1] + nums[i-1];
    }

    rightSum[numsSize-1] = 0;
    for (int i = numsSize-2; i >= 0; i--) {
        rightSum[i] = rightSum[i+1] + nums[i+1];
    }

    for (int i = 0; i < numsSize; i++) {
        answer[i] = abs(leftSum[i] - rightSum[i]);
    }

    free(leftSum);
    free(rightSum);
    return answer;
}