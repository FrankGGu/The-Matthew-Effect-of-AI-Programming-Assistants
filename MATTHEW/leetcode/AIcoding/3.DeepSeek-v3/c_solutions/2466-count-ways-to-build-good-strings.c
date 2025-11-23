int countGoodStrings(int low, int high, int zero, int one) {
    int mod = 1000000007;
    int dp[high + 1];
    for (int i = 0; i <= high; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 1; i <= high; i++) {
        if (i >= zero) {
            dp[i] = (dp[i] + dp[i - zero]) % mod;
        }
        if (i >= one) {
            dp[i] = (dp[i] + dp[i - one]) % mod;
        }
    }

    int result = 0;
    for (int i = low; i <= high; i++) {
        result = (result + dp[i]) % mod;
    }
    return result;
}