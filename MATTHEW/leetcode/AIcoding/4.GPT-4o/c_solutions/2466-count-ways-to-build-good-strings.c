#define MOD 1000000007

int countGoodStrings(int low, int high, int zero, int one) {
    int dp[high + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 0; i <= high; i++) {
        if (i + zero <= high) {
            dp[i + zero] = (dp[i + zero] + dp[i]) % MOD;
        }
        if (i + one <= high) {
            dp[i + one] = (dp[i + one] + dp[i]) % MOD;
        }
    }

    long long result = 0;
    for (int i = low; i <= high; i++) {
        result = (result + dp[i]) % MOD;
    }

    return (int)result;
}