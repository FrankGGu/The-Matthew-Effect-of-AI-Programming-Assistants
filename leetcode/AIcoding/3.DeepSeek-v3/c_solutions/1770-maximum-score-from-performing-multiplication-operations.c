int maximumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int n = numsSize;
    int m = multipliersSize;
    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int*)malloc((m + 1) * sizeof(int));
        for (int j = 0; j <= m; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = m - 1; i >= 0; i--) {
        for (int left = i; left >= 0; left--) {
            int mult = multipliers[i];
            int right = n - 1 - (i - left);
            dp[i][left] = fmax(mult * nums[left] + dp[i + 1][left + 1],
                               mult * nums[right] + dp[i + 1][left]);
        }
    }

    int result = dp[0][0];
    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}