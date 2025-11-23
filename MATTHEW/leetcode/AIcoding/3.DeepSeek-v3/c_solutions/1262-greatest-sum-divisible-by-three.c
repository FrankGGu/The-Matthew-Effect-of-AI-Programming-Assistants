int maxSumDivThree(int* nums, int numsSize) {
    int dp[3] = {0, -100000, -100000};
    for (int i = 0; i < numsSize; i++) {
        int mod = nums[i] % 3;
        int a = dp[(3 - mod) % 3];
        int b = dp[(4 - mod) % 3];
        int c = dp[(5 - mod) % 3];
        int new_dp[3] = {dp[0], dp[1], dp[2]};
        if (a >= 0) new_dp[mod] = fmax(new_dp[mod], a + nums[i]);
        if (b >= 0) new_dp[(mod + 1) % 3] = fmax(new_dp[(mod + 1) % 3], b + nums[i]);
        if (c >= 0) new_dp[(mod + 2) % 3] = fmax(new_dp[(mod + 2) % 3], c + nums[i]);
        dp[0] = new_dp[0];
        dp[1] = new_dp[1];
        dp[2] = new_dp[2];
    }
    return dp[0];
}