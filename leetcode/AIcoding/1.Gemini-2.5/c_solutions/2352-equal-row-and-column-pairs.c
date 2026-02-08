int equalPairs(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int match = 1;
            for (int k = 0; k < n; k++) {
                if (grid[i][k] != grid[k][j]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
            }
        }
    }

    return count;
}