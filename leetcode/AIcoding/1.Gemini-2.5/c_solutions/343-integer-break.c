int integerBreak(int n) {
    if (n == 2) {
        return 1;
    }
    if (n == 3) {
        return 2;
    }

    int dp[n + 1];
    dp[0] = 0; // Not used as a factor, but initializing for safety
    dp[1] = 1; // Used as a factor, e.g., for max(1, dp[1])
    dp[2] = 2; // When 2 is a factor, it's better to use 2 itself than break it (1*1=1)
    dp[3] = 3; // When 3 is a factor, it's better to use 3 itself than break it (1*2=2)

    for (int i = 4; i <= n; i++) {
        dp[i] = 0;
        for (int j = 1; j <= i / 2; j++) {
            // Option 1: Break i into j and (i-j), where (i-j) is not further broken
            // The product is j * (i-j)
            // Option 2: Break i into j and (i-j), where (i-j) is optimally broken
            // The product is j * dp[i-j]
            // We take the maximum of these two options for the current j,
            // and then take the maximum over all possible j.
            int product1 = j * dp[i - j];
            int product2 = j * (i - j);

            if (product1 > dp[i]) {
                dp[i] = product1;
            }
            if (product2 > dp[i]) {
                dp[i] = product2;
            }
        }
    }

    return dp[n];
}