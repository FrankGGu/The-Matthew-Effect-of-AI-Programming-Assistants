int* getSumAbsoluteDifferences(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int leftSum = 0;
    for (int i = 0; i < numsSize; i++) {
        int leftCount = i;
        int rightCount = numsSize - i - 1;

        int leftTotal = leftCount * nums[i] - leftSum;
        int rightTotal = (totalSum - leftSum - nums[i]) - rightCount * nums[i];

        result[i] = leftTotal + rightTotal;
        leftSum += nums[i];
    }

    return result;
}