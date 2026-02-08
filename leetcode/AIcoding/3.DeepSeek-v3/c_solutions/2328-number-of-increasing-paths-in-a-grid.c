int mod = 1e9 + 7;

int dfs(int** grid, int m, int n, int i, int j, int** dp) {
    if (dp[i][j] != -1) return dp[i][j];

    long long count = 1;
    int dirs[4][2] = {{0,1}, {0,-1}, {1,0}, {-1,0}};

    for (int k = 0; k < 4; k++) {
        int x = i + dirs[k][0];
        int y = j + dirs[k][1];

        if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] > grid[i][j]) {
            count = (count + dfs(grid, m, n, x, y, dp)) % mod;
        }
    }

    return dp[i][j] = count;
}

int countPaths(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = -1;
        }
    }

    long long result = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            result = (result + dfs(grid, m, n, i, j, dp)) % mod;
        }
    }

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}