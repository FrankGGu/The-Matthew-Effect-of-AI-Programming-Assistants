int dirs[4][2] = {{0,1},{1,0},{0,-1},{-1,0}};

bool dfs(char** grid, int gridSize, int* gridColSize, int t, int x, int y, int tx, int ty, int*** memo) {
    if (x == tx && y == ty) return true;
    if (t >= 200) return false;
    if (memo[t][x][y] != -1) return memo[t][x][y];

    int n = gridSize, m = *gridColSize;
    for (int k = 0; k < 4; k++) {
        int nx = x + dirs[k][0];
        int ny = y + dirs[k][1];
        if (nx < 0 || nx >= n || ny < 0 || ny >= m) continue;

        char c = grid[nx][ny];
        if (c == '#') continue;
        if (c == '.' && dfs(grid, n, gridColSize, t+1, nx, ny, tx, ty, memo)) {
            memo[t][x][y] = 1;
            return true;
        }
        if (c == '*') {
            int period = 2;
            int state = (t / period) % 2;
            if (state == 0) {
                if (dfs(grid, n, gridColSize, t+1, nx, ny, tx, ty, memo)) {
                    memo[t][x][y] = 1;
                    return true;
                }
            } else {
                if (dfs(grid, n, gridColSize, t+1, x, y, tx, ty, memo)) {
                    memo[t][x][y] = 1;
                    return true;
                }
            }
        }
    }
    memo[t][x][y] = 0;
    return false;
}

bool escapeMaze(char*** maze, int mazeSize, int* mazeColSize) {
    int n = mazeSize, m = mazeColSize[0];
    int sx = 0, sy = 0, tx = n-1, ty = m-1;

    int*** memo = (int***)malloc(201 * sizeof(int**));
    for (int t = 0; t < 201; t++) {
        memo[t] = (int**)malloc(n * sizeof(int*));
        for (int i = 0; i < n; i++) {
            memo[t][i] = (int*)malloc(m * sizeof(int));
            for (int j = 0; j < m; j++) {
                memo[t][i][j] = -1;
            }
        }
    }

    bool res = dfs(maze[0], n, &m, 0, sx, sy, tx, ty, memo);

    for (int t = 0; t < 201; t++) {
        for (int i = 0; i < n; i++) {
            free(memo[t][i]);
        }
        free(memo[t]);
    }
    free(memo);

    return res;
}