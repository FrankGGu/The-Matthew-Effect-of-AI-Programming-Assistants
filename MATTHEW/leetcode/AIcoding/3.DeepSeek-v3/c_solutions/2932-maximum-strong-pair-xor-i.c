int maximumStrongPairXor(int* nums, int numsSize) {
    int maxXor = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int x = nums[i];
            int y = nums[j];
            if (abs(x - y) <= (x < y ? x : y)) {
                int xorVal = x ^ y;
                if (xorVal > maxXor) {
                    maxXor = xorVal;
                }
            }
        }
    }
    return maxXor;
}