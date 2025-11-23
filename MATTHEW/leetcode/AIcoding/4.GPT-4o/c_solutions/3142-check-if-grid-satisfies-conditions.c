bool checkGrid(int** grid, int gridSize, int* gridColSize) {
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            int val = grid[i][j];
            if (val < 1 || val > gridSize) return false;
            for (int x = 0; x < gridSize; x++) {
                if (x != i && grid[x][j] == val) return false;
                if (x != j && grid[i][x] == val) return false;
            }
        }
    }
    return true;
}