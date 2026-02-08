int max(int a, int b) {
    return a > b ? a : b;
}

char* stoneGameIII(int* stoneValue, int stoneValueSize) {
    int n = stoneValueSize;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = 0;
    }

    for (int i = n - 1; i >= 0; i--) {
        dp[i] = stoneValue[i] - dp[i + 1];
        if (i + 2 <= n) {
            dp[i] = max(dp[i], stoneValue[i] + stoneValue[i + 1] - dp[i + 2]);
        }
        if (i + 3 <= n) {
            dp[i] = max(dp[i], stoneValue[i] + stoneValue[i + 1] + stoneValue[i + 2] - dp[i + 3]);
        }
    }

    char* result;
    if (dp[0] > 0) {
        result = "Alice";
    } else if (dp[0] < 0) {
        result = "Bob";
    } else {
        result = "Tie";
    }

    free(dp);
    return result;
}