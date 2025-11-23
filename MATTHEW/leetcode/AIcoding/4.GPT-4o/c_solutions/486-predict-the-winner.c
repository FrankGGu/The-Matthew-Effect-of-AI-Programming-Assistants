bool PredictTheWinner(int* nums, int numsSize) {
    int dp[numsSize][numsSize];
    for (int i = 0; i < numsSize; i++) {
        dp[i][i] = nums[i];
    }
    for (int len = 2; len <= numsSize; len++) {
        for (int i = 0; i <= numsSize - len; i++) {
            int j = i + len - 1;
            dp[i][j] = fmax(nums[i] - dp[i + 1][j], nums[j] - dp[i][j - 1]);
        }
    }
    return dp[0][numsSize - 1 >= 0;
}