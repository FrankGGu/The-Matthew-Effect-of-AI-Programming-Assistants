double* dicesProbability(int n, int* returnSize) {
    int dp[12][70] = {0};
    for (int i = 1; i <= 6; i++) {
        dp[1][i] = 1;
    }
    for (int i = 2; i <= n; i++) {
        for (int j = i; j <= 6 * i; j++) {
            for (int k = 1; k <= 6; k++) {
                if (j - k >= i - 1) {
                    dp[i][j] += dp[i - 1][j - k];
                }
            }
        }
    }
    double total = pow(6, n);
    *returnSize = 5 * n + 1;
    double *res = (double *)malloc(sizeof(double) * (*returnSize));
    for (int i = n; i <= 6 * n; i++) {
        res[i - n] = dp[n][i] / total;
    }
    return res;
}