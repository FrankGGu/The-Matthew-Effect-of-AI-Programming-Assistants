int findIntegers(int n) {
    int dp[32] = {0};
    dp[0] = 1;
    dp[1] = 2;

    for (int i = 2; i < 32; i++) {
        dp[i] = dp[i - 1] + dp[i - 2];
    }

    int result = 0;
    for (int i = 31, prev_bit = 0; i >= 0; i--) {
        if (n & (1 << i)) {
            result += dp[i];
            if (prev_bit) {
                return result;
            }
            prev_bit = 1;
        } else {
            prev_bit = 0;
        }
    }

    return result + 1;
}