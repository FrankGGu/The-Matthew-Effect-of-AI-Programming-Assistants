int stoneGameV(int* stoneValue, int stoneValueSize) {
    int dp[stoneValueSize + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < stoneValueSize; i++) {
        dp[i + 1] = dp[i] + stoneValue[i];
    }

    int result = 0;
    for (int i = 1; i <= stoneValueSize; i++) {
        for (int j = i; j < stoneValueSize; j++) {
            int left = dp[j + 1] - dp[i - 1];
            int right = dp[stoneValueSize] - left;
            if (left > right) {
                result = result > right + dp[i - 1] ? result : right + dp[i - 1];
            } else if (left < right) {
                result = result > left + dp[i - 1] ? result : left + dp[i - 1];
            } else {
                result = result > left + dp[i - 1] ? result : left + dp[i - 1];
            }
        }
    }

    return result;
}