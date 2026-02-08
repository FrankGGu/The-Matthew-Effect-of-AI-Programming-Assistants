int minOperations(int* nums, int numsSize, int k) {
    int xor_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        xor_sum ^= nums[i];
    }
    if (xor_sum == k) {
        return 0;
    }
    return 1;
}