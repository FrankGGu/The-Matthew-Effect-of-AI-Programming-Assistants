int removeBoxes(int* boxes, int boxesSize) {
    int n = boxesSize;
    int dp[100][100][100] = {0};

    for (int i = 0; i < n; i++) {
        for (int k = 0; k < n; k++) {
            dp[i][i][k] = (k + 1) * (k + 1);
        }
    }

    for (int l = 2; l <= n; l++) {
        for (int i = 0; i <= n - l; i++) {
            int j = i + l - 1;
            for (int k = 0; k <= i; k++) {
                int res = (k + 1) * (k + 1) + dp[i + 1][j][0];
                for (int m = i + 1; m <= j; m++) {
                    if (boxes[m] == boxes[i]) {
                        int candidate = dp[i + 1][m - 1][0] + dp[m][j][k + 1];
                        if (candidate > res) res = candidate;
                    }
                }
                dp[i][j][k] = res;
            }
        }
    }

    return n == 0 ? 0 : dp[0][n - 1][0];
}