int countNumbersWithNonDecreasingDigits(int n) {
    if (n == 0) return 1;

    int dp[10] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};

    for (int i = 2; i <= n; i++) {
        for (int j = 9; j >= 0; j--) {
            for (int k = j + 1; k <= 9; k++) {
                dp[j] += dp[k];
            }
        }
    }

    int total = 0;
    for (int i = 0; i < 10; i++) {
        total += dp[i];
    }

    return total;
}