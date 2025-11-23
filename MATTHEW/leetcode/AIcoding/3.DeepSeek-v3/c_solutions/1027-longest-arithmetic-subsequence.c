int longestArithSeqLength(int* nums, int numsSize) {
    int max_val = 0;
    int min_val = 1000;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) max_val = nums[i];
        if (nums[i] < min_val) min_val = nums[i];
    }

    int diff_range = max_val - min_val;
    int max_len = 1;

    for (int diff = -diff_range; diff <= diff_range; diff++) {
        int dp[1001] = {0};
        for (int i = 0; i < numsSize; i++) {
            int prev = nums[i] - diff;
            if (prev >= min_val && prev <= max_val && dp[prev] > 0) {
                dp[nums[i]] = dp[prev] + 1;
                if (dp[nums[i]] > max_len) {
                    max_len = dp[nums[i]];
                }
            } else {
                dp[nums[i]] = fmax(dp[nums[i]], 1);
            }
        }
    }

    return max_len;
}