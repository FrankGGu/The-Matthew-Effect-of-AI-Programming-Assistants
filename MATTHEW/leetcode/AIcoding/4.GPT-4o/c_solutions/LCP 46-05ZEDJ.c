int maxVolunteerAssignments(int **A, int ASize, int *AColSize) {
    int n = ASize, m = AColSize[0];
    int dp[1 << n][m];
    memset(dp, 0, sizeof(dp));

    for (int mask = 0; mask < (1 << n); mask++) {
        for (int j = 0; j < m; j++) {
            if (dp[mask][j] == 0 && mask != 0) continue;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0 && A[i][j]) {
                    dp[mask | (1 << i)][j + 1] = fmax(dp[mask | (1 << i)][j + 1], dp[mask][j] + 1);
                }
            }
        }
    }

    int res = 0;
    for (int mask = 0; mask < (1 << n); mask++) {
        res = fmax(res, dp[mask][m]);
    }

    return res;
}