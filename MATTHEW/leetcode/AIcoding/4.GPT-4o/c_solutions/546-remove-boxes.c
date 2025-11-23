int removeBoxes(int* boxes, int boxesSize) {
    int dp[100][100][100] = {0};

    for (int i = 0; i < boxesSize; i++) {
        for (int j = 0; j <= i; j++) {
            for (int k = 0; k <= i; k++) {
                if (j == i) {
                    dp[i][j][k] = (k + 1) * (k + 1);
                } else {
                    dp[i][j][k] = dp[i][j][k - 1];
                    if (boxes[j] == boxes[i]) {
                        dp[i][j][k] = fmax(dp[i][j][k], dp[i - 1][j - 1][k + 1] + (k + 1) * (k + 1));
                    }
                }
            }
        }
    }

    return dp[boxesSize - 1][0][0];
}