#define MOD 1000000007

int countWays(int** ranges, int rangesSize, int* rangesColSize) {
    long long dp[rangesSize + 1];
    dp[0] = 1;
    for (int i = 1; i <= rangesSize; i++) {
        dp[i] = dp[i - 1];
        for (int j = 0; j < i - 1; j++) {
            if (ranges[j][1] < ranges[i - 1][0]) {
                dp[i] = (dp[i] + dp[j + 1]) % MOD;
            }
        }
    }
    return dp[rangesSize];
}