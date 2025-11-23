int dfs(int** grid1, int** grid2, int x, int y, int row, int col) {
    if (x < 0 || x >= row || y < 0 || y >= col || grid2[x][y] == 0) {
        return 1;
    }
    if (grid1[x][y] == 0) {
        return 0;
    }

    grid2[x][y] = 0;

    int up = dfs(grid1, grid2, x - 1, y, row, col);
    int down = dfs(grid1, grid2, x + 1, y, row, col);
    int left = dfs(grid1, grid2, x, y - 1, row, col);
    int right = dfs(grid1, grid2, x, y + 1, row, col);

    return up & down & left & right;
}

int countSubIslands(int** grid1, int grid1Size, int* grid1ColSize, int** grid2, int grid2Size, int* grid2ColSize) {
    int count = 0;
    int row = grid1Size;
    int col = grid1ColSize[0];

    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            if (grid2[i][j] == 1) {
                if (dfs(grid1, grid2, i, j, row, col)) {
                    count++;
                }
            }
        }
    }

    return count;
}