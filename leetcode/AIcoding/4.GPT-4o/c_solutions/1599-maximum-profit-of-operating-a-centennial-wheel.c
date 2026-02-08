int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maxProfit(int* gain, int gainSize, int* time, int timeSize) {
    int dp[gainSize + 1][timeSize + 1];
    for (int i = 0; i <= gainSize; i++) {
        for (int j = 0; j <= timeSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= gainSize; i++) {
        for (int j = 1; j <= timeSize; j++) {
            if (j >= time[i - 1]) {
                dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - time[i - 1]] + gain[i - 1]);
            } else {
                dp[i][j] = dp[i - 1][j];
            }
        }
    }

    return dp[gainSize][timeSize];
}