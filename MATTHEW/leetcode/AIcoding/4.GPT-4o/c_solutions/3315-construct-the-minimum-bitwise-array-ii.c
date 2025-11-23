int* constructMinimumBitwiseArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    for (int i = 0; i < numsSize; i++) {
        result[i] = 1;
        for (int j = 0; j < 32; j++) {
            if (nums[i] & (1 << j)) {
                result[i] |= (1 << j);
            }
        }
    }
    return result;
}