int minOperations(int* nums, int numsSize) {
    int totalOps = 0;
    int maxBits = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int bits = 0;

        while (num > 0) {
            if (num & 1) {
                totalOps++;
                num--;
            } else {
                num >>= 1;
                bits++;
            }
        }

        if (bits > maxBits) {
            maxBits = bits;
        }
    }

    return totalOps + maxBits;
}