int maxScore(int* nums, int numsSize, int x) {
    int dp[2];
    dp[0] = dp[1] = INT_MIN;
    dp[nums[0] % 2] = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int parity = nums[i] % 2;
        int other = 1 - parity;

        int new_val;
        if (dp[parity] != INT_MIN) {
            new_val = dp[parity] + nums[i];
        } else {
            new_val = INT_MIN;
        }

        if (dp[other] != INT_MIN) {
            new_val = fmax(new_val, dp[other] + nums[i] - x);
        }

        dp[parity] = fmax(dp[parity], new_val);
    }

    return fmax(dp[0], dp[1]);
}