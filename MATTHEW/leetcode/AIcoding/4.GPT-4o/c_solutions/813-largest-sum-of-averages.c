double largestSumOfAverages(int* A, int ASize, int K) {
    double dp[101][101] = {0};
    double sum[101] = {0};

    for (int i = 0; i < ASize; i++) {
        sum[i + 1] = sum[i] + A[i];
    }

    for (int i = 1; i <= ASize; i++) {
        dp[i][1] = sum[i] / i;
    }

    for (int k = 2; k <= K; k++) {
        for (int i = k; i <= ASize; i++) {
            for (int j = k - 1; j < i; j++) {
                dp[i][k] = fmax(dp[i][k], dp[j][k - 1] + (sum[i] - sum[j]) / (i - j));
            }
        }
    }

    return dp[ASize][K];
}