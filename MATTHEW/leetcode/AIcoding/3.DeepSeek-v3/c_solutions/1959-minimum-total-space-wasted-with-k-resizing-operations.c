int minSpaceWastedKResizing(int* nums, int numsSize, int k) {
    int n = numsSize;
    int dp[n][k + 1];
    int prefix[n];
    int maxVal[n][n];

    prefix[0] = nums[0];
    for (int i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    for (int i = 0; i < n; i++) {
        int curMax = 0;
        for (int j = i; j < n; j++) {
            if (nums[j] > curMax) curMax = nums[j];
            maxVal[i][j] = curMax;
        }
    }

    for (int i = 0; i < n; i++) {
        int len = i + 1;
        int waste = maxVal[0][i] * len - prefix[i];
        dp[i][0] = waste;
        for (int j = 1; j <= k; j++) {
            dp[i][j] = INT_MAX / 2;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 1; j <= k; j++) {
            for (int p = 0; p < i; p++) {
                int len = i - p;
                int waste = maxVal[p + 1][i] * len - (prefix[i] - prefix[p]);
                if (dp[p][j - 1] + waste < dp[i][j]) {
                    dp[i][j] = dp[p][j - 1] + waste;
                }
            }
        }
    }

    return dp[n - 1][k];
}