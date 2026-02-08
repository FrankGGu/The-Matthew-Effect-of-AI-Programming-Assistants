int maximumXOR(int* nums, int numsSize) {
    int maxXOR = 0;
    for (int i = 0; i < numsSize; i++) {
        maxXOR |= nums[i];
    }
    return maxXOR;
}