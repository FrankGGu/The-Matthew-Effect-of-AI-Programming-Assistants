int findMaximumXOR(int* nums, int numsSize) {
    int maxNum = 0, mask = 0, maxXor = 0;
    for (int i = 31; i >= 0; i--) {
        mask |= (1 << i);
        int potentialMax = maxXor | (1 << i);
        int prefixes[1024] = {0};
        for (int j = 0; j < numsSize; j++) {
            prefixes[(nums[j] & mask) >> i] = 1;
        }
        for (int j = 0; j < 1024; j++) {
            if (prefixes[j] && prefixes[j ^ (potentialMax >> i)]) {
                maxXor = potentialMax;
                break;
            }
        }
    }
    return maxXor;
}