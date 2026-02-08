int stoneGameV(int* stoneValue, int stoneValueSize) {
    int n = stoneValueSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + stoneValue[i];
    }

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i + len <= n; i++) {
            int j = i + len - 1;
            for (int k = i; k < j; k++) {
                int leftSum = prefix[k + 1] - prefix[i];
                int rightSum = prefix[j + 1] - prefix[k + 1];
                if (leftSum < rightSum) {
                    dp[i][j] = fmax(dp[i][j], leftSum + dp[i][k]);
                } else if (leftSum > rightSum) {
                    dp[i][j] = fmax(dp[i][j], rightSum + dp[k + 1][j]);
                } else {
                    dp[i][j] = fmax(dp[i][j], leftSum + fmax(dp[i][k], dp[k + 1][j]));
                }
            }
        }
    }

    int result = dp[0][n - 1];

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefix);

    return result;
}