int stoneGameVII(int* stones, int stonesSize) {
    int n = stonesSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + stones[i];
    }

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            int scoreRemoveFirst = prefix[j + 1] - prefix[i + 1];
            int scoreRemoveLast = prefix[j] - prefix[i];

            dp[i][j] = scoreRemoveFirst - dp[i + 1][j];
            int candidate = scoreRemoveLast - dp[i][j - 1];
            if (candidate > dp[i][j]) {
                dp[i][j] = candidate;
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