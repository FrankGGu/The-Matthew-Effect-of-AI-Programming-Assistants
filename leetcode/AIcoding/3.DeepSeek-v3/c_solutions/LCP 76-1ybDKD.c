int magicalBoard(int m, int n, int** s, int sSize, int* sColSize) {
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < sSize; i++) {
        int x = s[i][0] - 1;
        int y = s[i][1] - 1;
        dp[x][y] = -1;
    }

    if (dp[0][0] == -1) return 0;

    dp[0][0] = 1;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (dp[i][j] == -1) continue;
            if (i > 0 && dp[i-1][j] != -1) {
                dp[i][j] = (dp[i][j] + dp[i-1][j]) % 1000000007;
            }
            if (j > 0 && dp[i][j-1] != -1) {
                dp[i][j] = (dp[i][j] + dp[i][j-1]) % 1000000007;
            }
        }
    }

    int result = dp[m-1][n-1] == -1 ? 0 : dp[m-1][n-1];

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}