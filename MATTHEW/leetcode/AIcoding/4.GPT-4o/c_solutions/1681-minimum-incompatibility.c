int minIncompatibility(int* nums, int numsSize, int k) {
    int max_mask = 1 << numsSize;
    int dp[max_mask];
    int mask_size = max_mask / 2;
    for (int i = 0; i < max_mask; i++) dp[i] = -1;
    dp[0] = 0;

    for (int i = 1; i <= k; i++) {
        for (int j = max_mask - 1; j >= 0; j--) {
            if (dp[j] == -1) continue;

            int used = 0, current_sum = 0, min_num = 51, max_num = -1;
            for (int m = 0; m < numsSize; m++) {
                if (j & (1 << m)) {
                    used++;
                    current_sum += nums[m];
                    if (nums[m] < min_num) min_num = nums[m];
                    if (nums[m] > max_num) max_num = nums[m];
                }
            }

            if (used == 0 || used > numsSize / k) continue;

            for (int m = 0; m < max_mask; m++) {
                if (dp[m] != -1 || (m & j) != 0) continue;
                dp[m | j] = dp[j] + (max_num - min_num);
            }
        }
    }

    int result = -1;
    for (int i = 0; i < max_mask; i++) {
        if (dp[i] != -1 && __builtin_popcount(i) == numsSize) {
            if (result == -1 || result > dp[i]) result = dp[i];
        }
    }

    return result;
}