int maximumANDSum(int* nums, int numsSize, int numSlots) {
    int n = numsSize;
    int m = numSlots;
    int mask_max = 1;
    for (int i = 0; i < m; i++) mask_max *= 3;

    int* dp = (int*)malloc((mask_max) * sizeof(int));
    for (int i = 0; i < mask_max; i++) dp[i] = 0;

    for (int i = 0; i < n; i++) {
        int* new_dp = (int*)malloc((mask_max) * sizeof(int));
        for (int j = 0; j < mask_max; j++) new_dp[j] = dp[j];

        for (int mask = 0; mask < mask_max; mask++) {
            int cur = mask;
            for (int k = 0, bit = 1; k < m; k++, bit *= 3) {
                if ((cur / bit) % 3 < 2) {
                    int new_mask = mask + bit;
                    int val = dp[mask] + (nums[i] & (k + 1));
                    if (val > new_dp[new_mask]) {
                        new_dp[new_mask] = val;
                    }
                }
            }
        }
        free(dp);
        dp = new_dp;
    }

    int res = 0;
    for (int mask = 0; mask < mask_max; mask++) {
        if (dp[mask] > res) res = dp[mask];
    }
    free(dp);
    return res;
}