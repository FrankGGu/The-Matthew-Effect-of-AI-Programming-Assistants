int minimumOperations(int* nums, int numsSize) {
    int n = numsSize;
    int dp[n + 1][4];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 4; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= 3; j++) {
            int cost = (nums[i - 1] != j) ? 1 : 0;
            int min_prev = n;
            for (int k = 1; k <= j; k++) {
                if (dp[i - 1][k] < min_prev) {
                    min_prev = dp[i - 1][k];
                }
            }
            dp[i][j] = min_prev + cost;
        }
    }

    int result = n;
    for (int j = 1; j <= 3; j++) {
        if (dp[n][j] < result) {
            result = dp[n][j];
        }
    }

    return result;
}