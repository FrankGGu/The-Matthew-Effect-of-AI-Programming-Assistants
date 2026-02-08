int orderOfLargestPlusSign(int N, int** mines, int minesSize, int* minesColSize) {
    int grid[N][N];
    memset(grid, 1, sizeof(grid));

    for (int i = 0; i < minesSize; i++) {
        grid[mines[i][0]][mines[i][1]] = 0;
    }

    int maxOrder = 0;
    int dp[N][N];
    memset(dp, 0, sizeof(dp));

    for (int r = 0; r < N; r++) {
        for (int c = 0; c < N; c++) {
            if (grid[r][c] == 1) {
                dp[r][c] = (r == 0 || c == 0) ? 1 : fmin(fmin(dp[r - 1][c], dp[r][c - 1]), fmin(dp[r - 1][c - 1], dp[r][c + 1])) + 1;
                maxOrder = fmax(maxOrder, dp[r][c]);
            }
        }
    }

    return maxOrder;
}