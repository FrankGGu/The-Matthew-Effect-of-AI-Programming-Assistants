int* findIndices(int* nums, int numsSize, int* returnSize) {
    int* result = malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i - nums[i] >= 0 && i - nums[i] < numsSize && nums[i - nums[i]] == i) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}