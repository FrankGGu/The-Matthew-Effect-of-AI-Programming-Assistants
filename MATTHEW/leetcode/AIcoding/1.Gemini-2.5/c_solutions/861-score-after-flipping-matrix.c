int matrixScore(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    for (int i = 0; i < m; i++) {
        if (grid[i][0] == 0) {
            for (int j = 0; j < n; j++) {
                grid[i][j] = 1 - grid[i][j];
            }
        }
    }

    int score = 0;

    score += m * (1 << (n - 1));

    for (int j = 1; j < n; j++) {
        int ones_count = 0;
        for (int i = 0; i < m; i++) {
            if (grid[i][j] == 1) {
                ones_count++;
            }
        }

        int max_ones_for_col_j = (ones_count > m - ones_count) ? ones_count : (m - ones_count);

        score += max_ones_for_col_j * (1 << (n - 1 - j));
    }

    return score;
}