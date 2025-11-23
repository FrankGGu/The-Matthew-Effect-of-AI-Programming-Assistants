/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* singleNumber(int* nums, int numsSize, int* returnSize) {
    long xor_all = 0;
    for (int i = 0; i < numsSize; i++) {
        xor_all ^= nums[i];
    }

    long diff_bit = xor_all & (-xor_all);

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = 0;

    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] & diff_bit) == 0) {
            result[0] ^= nums[i];
        } else {
            result[1] ^= nums[i];
        }
    }

    *returnSize = 2;
    return result;
}