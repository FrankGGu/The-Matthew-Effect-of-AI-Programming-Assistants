int minOperations(char** grid, int gridSize, int* gridColSize) {
    int n = gridSize, m = *gridColSize, ans = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 'Y') {
                ans++;
            }
        }
    }
    return n * m - ans;
}