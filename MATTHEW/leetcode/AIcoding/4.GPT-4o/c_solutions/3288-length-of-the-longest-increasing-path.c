int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) return 0;

    int rows = matrixSize, cols = *matrixColSize;
    int dp[rows][cols];
    memset(dp, 0, sizeof(dp));
    int longest = 0;

    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    int isValid(int x, int y) {
        return x >= 0 && x < rows && y >= 0 && y < cols;
    }

    int dfs(int x, int y) {
        if (dp[x][y] != 0) return dp[x][y];
        dp[x][y] = 1;

        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i][0];
            int newY = y + directions[i][1];
            if (isValid(newX, newY) && matrix[newX][newY] > matrix[x][y]) {
                dp[x][y] = fmax(dp[x][y], 1 + dfs(newX, newY));
            }
        }
        return dp[x][y];
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            longest = fmax(longest, dfs(i, j));
        }
    }

    return longest;
}