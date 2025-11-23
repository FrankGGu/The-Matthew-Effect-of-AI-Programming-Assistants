int countSubIslands(int** grid1, int grid1Size, int* grid1ColSize, int** grid2, int grid2Size, int* grid2ColSize) {
    int m = grid1Size;
    int n = grid1ColSize[0];
    int count = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid2[i][j] == 1) {
                if (dfs(grid1, grid2, i, j, m, n)) {
                    count++;
                }
            }
        }
    }
    return count;
}

int dfs(int** grid1, int** grid2, int i, int j, int m, int n) {
    if (i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] == 0) {
        return 1;
    }

    grid2[i][j] = 0;
    int res = 1;
    if (grid1[i][j] == 0) {
        res = 0;
    }

    res = dfs(grid1, grid2, i+1, j, m, n) && res;
    res = dfs(grid1, grid2, i-1, j, m, n) && res;
    res = dfs(grid1, grid2, i, j+1, m, n) && res;
    res = dfs(grid1, grid2, i, j-1, m, n) && res;

    return res;
}