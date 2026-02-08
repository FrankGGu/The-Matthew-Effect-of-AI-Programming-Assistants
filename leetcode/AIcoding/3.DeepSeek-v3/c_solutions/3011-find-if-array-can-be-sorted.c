int canSortArray(int* nums, int numsSize) {
    int lastMax = -1;
    int curMax = nums[0];
    int curMin = nums[0];
    int curBits = __builtin_popcount(nums[0]);

    for (int i = 1; i < numsSize; i++) {
        int bits = __builtin_popcount(nums[i]);
        if (bits == curBits) {
            if (nums[i] > curMax) curMax = nums[i];
            if (nums[i] < curMin) curMin = nums[i];
        } else {
            if (curMin < lastMax) return 0;
            lastMax = curMax;
            curBits = bits;
            curMax = nums[i];
            curMin = nums[i];
        }
    }

    return curMin >= lastMax;
}