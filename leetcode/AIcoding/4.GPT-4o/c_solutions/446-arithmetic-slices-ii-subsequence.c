int numberOfArithmeticSlices(int* A, int ASize) {
    if (ASize < 3) return 0;
    long long res = 0;
    long long dp[ASize][ASize];
    memset(dp, 0, sizeof(dp));

    for (int j = 1; j < ASize; j++) {
        for (int i = 0; i < j; i++) {
            long long diff = (long long)A[j] - A[i];
            if (diff <= INT_MAX && diff >= INT_MIN) {
                for (int k = 0; k < i; k++) {
                    if ((long long)A[i] - A[k] == diff) {
                        dp[i][j] += 1 + dp[k][i];
                    }
                }
                res += dp[i][j];
            }
        }
    }
    return res;
}