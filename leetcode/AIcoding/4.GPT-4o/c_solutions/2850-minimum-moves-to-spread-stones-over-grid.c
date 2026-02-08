int minMoves(int** grid, int gridSize, int* gridColSize) {
    int totalStones = 0, totalCells = gridSize * gridColSize[0];
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            totalStones += grid[i][j];
        }
    }
    int target = totalStones / totalCells;
    int moves = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > target) {
                moves += grid[i][j] - target;
            }
        }
    }
    return moves;
}