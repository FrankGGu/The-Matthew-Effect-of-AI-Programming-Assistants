int maximumXor(int* nums, int numsSize) {
    int maxXor = 0;
    for (int i = 0; i < numsSize; i++) {
        maxXor |= nums[i];
    }
    return maxXor;
}