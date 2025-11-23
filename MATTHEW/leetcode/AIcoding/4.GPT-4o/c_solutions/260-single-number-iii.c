int* singleNumber(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int xor = 0;
    for (int i = 0; i < numsSize; i++) {
        xor ^= nums[i];
    }
    int diff = xor & -xor;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] & diff) {
            result[0] ^= nums[i];
        } else {
            result[1] ^= nums[i];
        }
    }
    *returnSize = 2;
    return result;
}