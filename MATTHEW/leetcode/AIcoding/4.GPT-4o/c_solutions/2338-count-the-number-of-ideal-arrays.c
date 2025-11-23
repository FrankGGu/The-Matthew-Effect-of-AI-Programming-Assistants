#define MOD 1000000007

int countIdealArrays(int n, int maxValue) {
    long long dp[maxValue + 1];
    long long sum[maxValue + 1];
    int i, j;

    for (i = 0; i <= maxValue; i++) {
        dp[i] = 1;
        sum[i] = (i == 0) ? 0 : (sum[i - 1] + dp[i]) % MOD;
    }

    for (i = 1; i <= n; i++) {
        long long new_dp[maxValue + 1];
        for (j = 1; j <= maxValue; j++) {
            new_dp[j] = sum[j];
        }
        for (j = 1; j <= maxValue; j++) {
            sum[j] = (sum[j - 1] + new_dp[j]) % MOD;
        }
        for (j = 1; j <= maxValue; j++) {
            dp[j] = new_dp[j];
        }
    }

    long long result = 0;
    for (i = 1; i <= maxValue; i++) {
        result = (result + dp[i]) % MOD;
    }

    return result;
}