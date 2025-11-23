int countCopyArrays(int* original, int originalSize, int m) {
    int n = originalSize;
    int dp[n][m + 1];
    int prefix[n][m + 1];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= m; j++) {
            dp[i][j] = 0;
            prefix[i][j] = 0;
        }
    }

    for (int j = 1; j <= m; j++) {
        dp[0][j] = 1;
        prefix[0][j] = j;
    }

    for (int i = 1; i < n; i++) {
        for (int j = 1; j <= m; j++) {
            int maxVal = original[i - 1];
            int k = i - 1;
            while (k >= 0 && original[k] <= original[i]) {
                if (original[k] > maxVal) {
                    maxVal = original[k];
                }
                k--;
            }

            if (k >= 0) {
                dp[i][j] = prefix[k][j];
            } else {
                dp[i][j] = prefix[i - 1][j];
            }

            if (original[i] >= maxVal) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j]) % 1000000007;
            }
        }

        for (int j = 1; j <= m; j++) {
            prefix[i][j] = (prefix[i][j - 1] + dp[i][j]) % 1000000007;
        }
    }

    int result = 0;
    for (int j = 1; j <= m; j++) {
        result = (result + dp[n - 1][j]) % 1000000007;
    }
    return result;
}