int* getMaximumXor(int* nums, int numsSize, int maximumBit, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int xor_all = 0;
    for (int i = 0; i < numsSize; i++) {
        xor_all ^= nums[i];
    }

    int mask = (1 << maximumBit) - 1;

    for (int i = 0; i < numsSize; i++) {
        result[i] = (~xor_all) & mask;
        xor_all ^= nums[numsSize - 1 - i];
    }

    return result;
}