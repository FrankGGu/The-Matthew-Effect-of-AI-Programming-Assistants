int dp[1001][1001];

int longestSubsequence(int* nums, int numsSize, int target) {
    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j <= target; j++) {
            dp[i][j] = -1000000;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        int num = nums[i-1];
        for (int j = 0; j <= target; j++) {
            dp[i][j] = dp[i-1][j];
            if (j >= num && dp[i-1][j-num] != -1000000) {
                dp[i][j] = (dp[i][j] > dp[i-1][j-num] + 1) ? dp[i][j] : dp[i-1][j-num] + 1;
            }
        }
    }

    return dp[numsSize][target] >= 0 ? dp[numsSize][target] : -1;
}