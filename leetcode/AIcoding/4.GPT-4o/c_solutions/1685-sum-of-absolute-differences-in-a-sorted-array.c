int* getSumAbsoluteDifferences(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int total = 0;

    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        result[i] = (2 * i * nums[i] - total) + (total - (numsSize - i - 1) * nums[i]);
    }

    *returnSize = numsSize;
    return result;
}