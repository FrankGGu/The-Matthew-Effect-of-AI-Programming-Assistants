int minimumMoves(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int moves = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                moves++;
                for (int k = 0; k < n; k++) {
                    if (grid[i][k] == 1) grid[i][k] = 0;
                    if (grid[k][j] == 1) grid[k][j] = 0;
                }
                grid[i][j] = 0;
            }
        }
    }
    return moves;
}