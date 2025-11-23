int cherryPickup(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize, cols = gridColSize[0];
    int dp[rows][cols][cols];

    for (int i = 0; i < rows; i++) {
        for (int j1 = 0; j1 < cols; j1++) {
            for (int j2 = 0; j2 < cols; j2++) {
                dp[i][j1][j2] = (i == 0) ? (j1 == j2 ? grid[i][j1] : grid[i][j1] + grid[i][j2]) : 0;
            }
        }
    }

    for (int i = 1; i < rows; i++) {
        for (int j1 = 0; j1 < cols; j1++) {
            for (int j2 = 0; j2 < cols; j2++) {
                if (grid[i][j1] == -1 || grid[i][j2] == -1) continue;
                int maxCherries = 0;
                for (int nj1 = j1 - 1; nj1 <= j1 + 1; nj1++) {
                    for (int nj2 = j2 - 1; nj2 <= j2 + 1; nj2++) {
                        if (nj1 >= 0 && nj1 < cols && nj2 >= 0 && nj2 < cols) {
                            maxCherries = fmax(maxCherries, dp[i - 1][nj1][nj2]);
                        }
                    }
                }
                dp[i][j1][j2] = maxCherries + grid[i][j1] + (j1 == j2 ? 0 : grid[i][j2]);
            }
        }
    }

    int result = 0;
    for (int j1 = 0; j1 < cols; j1++) {
        for (int j2 = 0; j2 < cols; j2++) {
            result = fmax(result, dp[rows - 1][j1][j2]);
        }
    }
    return result;
}