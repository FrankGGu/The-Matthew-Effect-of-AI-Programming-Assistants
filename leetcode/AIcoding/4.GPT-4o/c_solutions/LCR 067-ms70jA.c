int findMaximumXOR(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    int maxBit = 0;
    while (maxNum) {
        maxBit++;
        maxNum >>= 1;
    }

    int maxXor = 0, mask = 0;
    for (int i = maxBit - 1; i >= 0; i--) {
        mask |= (1 << i);
        int currentXor = maxXor | (1 << i);
        int set = 0;
        int seen[1 << 16] = {0};

        for (int j = 0; j < numsSize; j++) {
            int temp = nums[j] & mask;
            if (seen[temp ^ currentXor]) {
                set = 1;
                break;
            }
            seen[temp] = 1;
        }

        if (set) {
            maxXor = currentXor;
        }
    }

    return maxXor;
}