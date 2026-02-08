bool canCutIntoSections(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize, m = *gridColSize;
    int total = n * m;
    int sum = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            sum += grid[i][j];
        }
    }

    if (sum % total != 0) return false;

    int target = sum / total;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] != target) return false;
        }
    }

    return true;
}