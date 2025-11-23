int* decompressRLElist(int* nums, int numsSize, int* returnSize) {
    *returnSize = 0;
    for (int i = 0; i < numsSize; i += 2) {
        *returnSize += nums[i];
    }

    int* result = (int*)malloc(*returnSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i += 2) {
        for (int j = 0; j < nums[i]; j++) {
            result[index++] = nums[i + 1];
        }
    }

    return result;
}