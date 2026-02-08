int numEnclaves(int** A, int ASize, int* AColSize) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int rows = ASize, cols = AColSize[0];

    void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || A[r][c] == 0) return;
        A[r][c] = 0; // Mark as visited
        for (int i = 0; i < 4; i++) {
            dfs(r + directions[i][0], c + directions[i][1]);
        }
    }

    for (int i = 0; i < rows; i++) {
        if (A[i][0] == 1) dfs(i, 0);
        if (A[i][cols - 1] == 1) dfs(i, cols - 1);
    }
    for (int j = 0; j < cols; j++) {
        if (A[0][j] == 1) dfs(0, j);
        if (A[rows - 1][j] == 1) dfs(rows - 1, j);
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (A[i][j] == 1) count++;
        }
    }

    return count;
}