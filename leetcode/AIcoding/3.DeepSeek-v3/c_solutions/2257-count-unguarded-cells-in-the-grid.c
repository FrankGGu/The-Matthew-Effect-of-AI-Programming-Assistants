int countUnguarded(int m, int n, int** guards, int guardsSize, int* guardsColSize, int** walls, int wallsSize, int* wallsColSize) {
    int** grid = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        grid[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i < guardsSize; i++) {
        grid[guards[i][0]][guards[i][1]] = 2;
    }

    for (int i = 0; i < wallsSize; i++) {
        grid[walls[i][0]][walls[i][1]] = 3;
    }

    for (int i = 0; i < guardsSize; i++) {
        int r = guards[i][0];
        int c = guards[i][1];

        for (int dr = -1; dr <= 1; dr += 2) {
            int nr = r + dr;
            while (nr >= 0 && nr < m && grid[nr][c] != 2 && grid[nr][c] != 3) {
                if (grid[nr][c] == 0) grid[nr][c] = 1;
                nr += dr;
            }
        }

        for (int dc = -1; dc <= 1; dc += 2) {
            int nc = c + dc;
            while (nc >= 0 && nc < n && grid[r][nc] != 2 && grid[r][nc] != 3) {
                if (grid[r][nc] == 0) grid[r][nc] = 1;
                nc += dc;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) count++;
        }
    }

    for (int i = 0; i < m; i++) {
        free(grid[i]);
    }
    free(grid);

    return count;
}