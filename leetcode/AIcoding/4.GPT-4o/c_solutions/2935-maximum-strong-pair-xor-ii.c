int maximumStrongPairXOR(int* nums, int numsSize) {
    int maxXor = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int xorValue = nums[i] ^ nums[j];
            if (xorValue > maxXor) {
                maxXor = xorValue;
            }
        }
    }
    return maxXor;
}