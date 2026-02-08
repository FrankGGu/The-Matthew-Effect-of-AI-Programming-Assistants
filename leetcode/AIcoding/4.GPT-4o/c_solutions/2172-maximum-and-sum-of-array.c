int maximumANDSum(int* nums, int numsSize, int numSlots) {
    int dp[1 << (2 * numSlots)];
    memset(dp, 0, sizeof(dp));
    for (int mask = 0; mask < (1 << (2 * numSlots)); mask++) {
        int count[2 * numSlots] = {0};
        for (int j = 0; j < numSlots; j++) {
            count[j] = (mask >> (2 * j)) & 3;
        }
        for (int i = 0; i < numsSize; i++) {
            for (int j = 0; j < numSlots; j++) {
                if (count[j] < 2) {
                    int newMask = mask | (1 << (2 * j + count[j]));
                    dp[newMask] = fmax(dp[newMask], dp[mask] + (j + 1) & nums[i]);
                }
            }
        }
    }
    return dp[(1 << (2 * numSlots)) - 1];
}