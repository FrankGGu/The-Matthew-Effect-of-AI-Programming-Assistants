#define MOD 1000000007

int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

int dfs(int** grid, int gridSize, int* gridColSize, int i, int j, int** dp) {
    if (dp[i][j] != -1) return dp[i][j];

    long long count = 1;
    for (int d = 0; d < 4; d++) {
        int ni = i + directions[d][0];
        int nj = j + directions[d][1];
        if (ni >= 0 && ni < gridSize && nj >= 0 && nj < gridColSize[0] && grid[ni][nj] > grid[i][j]) {
            count = (count + dfs(grid, gridSize, gridColSize, ni, nj, dp)) % MOD;
        }
    }
    return dp[i][j] = count;
}

int countPaths(int** grid, int gridSize, int* gridColSize) {
    int** dp = (int**)malloc(gridSize * sizeof(int*));
    for (int i = 0; i < gridSize; i++) {
        dp[i] = (int*)malloc(gridColSize[0] * sizeof(int));
        memset(dp[i], -1, gridColSize[0] * sizeof(int));
    }

    long long totalPaths = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            totalPaths = (totalPaths + dfs(grid, gridSize, gridColSize, i, j, dp)) % MOD;
        }
    }

    for (int i = 0; i < gridSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return (int)totalPaths;
}