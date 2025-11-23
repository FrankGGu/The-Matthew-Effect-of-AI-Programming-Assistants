int maxSumDivThree(int* nums, int numsSize) {
    int dp[3] = {0};
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int dp0 = dp[0], dp1 = dp[1], dp2 = dp[2];
        dp[num % 3] = fmax(dp[num % 3], dp0 + num);
        dp[(num % 3 + 1) % 3] = fmax(dp[(num % 3 + 1) % 3], dp1 + num);
        dp[(num % 3 + 2) % 3] = fmax(dp[(num % 3 + 2) % 3], dp2 + num);
    }
    return dp[0];
}