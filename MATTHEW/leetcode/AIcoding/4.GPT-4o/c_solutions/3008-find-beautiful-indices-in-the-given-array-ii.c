int* beautifulIndices(int* nums, int numsSize, int* returnSize) {
    int* result = malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i == 0 || i == numsSize - 1 || nums[i] > nums[i - 1] + nums[i + 1]) {
            result[*returnSize] = i;
            (*returnSize)++;
        }
    }

    return result;
}