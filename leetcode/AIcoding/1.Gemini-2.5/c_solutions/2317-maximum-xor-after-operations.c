int maximumXOR(int* nums, int numsSize) {
    int max_xor_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        max_xor_sum |= nums[i];
    }
    return max_xor_sum;
}