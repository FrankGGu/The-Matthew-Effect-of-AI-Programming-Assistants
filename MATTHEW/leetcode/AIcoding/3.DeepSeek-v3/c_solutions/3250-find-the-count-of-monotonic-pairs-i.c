int countOfPairs(int* nums, int numsSize) {
    int n = numsSize;
    int dp[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int j = 0; j < n; j++) {
        if (nums[0] <= j) {
            dp[0][j] = 1;
        }
    }

    for (int i = 1; i < n; i++) {
        int prefix[n];
        prefix[0] = dp[i-1][0];
        for (int j = 1; j < n; j++) {
            prefix[j] = prefix[j-1] + dp[i-1][j];
        }

        for (int j = 0; j < n; j++) {
            if (nums[i] <= j) {
                int upper = (nums[i-1] <= j) ? j : nums[i-1];
                if (upper >= n) upper = n-1;
                if (upper >= 0) {
                    dp[i][j] = prefix[upper];
                }
            }
        }
    }

    int result = 0;
    for (int j = 0; j < n; j++) {
        result += dp[n-1][j];
    }
    return result;
}