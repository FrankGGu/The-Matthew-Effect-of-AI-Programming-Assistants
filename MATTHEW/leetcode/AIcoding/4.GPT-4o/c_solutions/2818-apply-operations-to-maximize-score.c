int maximumScore(int* nums, int numsSize, int multipliersSize, int* multipliers) {
    int dp[1001][1001] = {0};
    for (int i = 0; i <= multipliersSize; i++) {
        for (int j = 0; j <= i; j++) {
            int left = nums[j] * multipliers[i - 1] + dp[i - 1][j + 1];
            int right = nums[numsSize - 1 - (i - j)] * multipliers[i - 1] + dp[i - 1][j];
            dp[i][j] = i == 0 ? 0 : (j == 0 ? right : (j == i ? left : fmax(left, right)));
        }
    }
    return dp[multipliersSize][0];
}