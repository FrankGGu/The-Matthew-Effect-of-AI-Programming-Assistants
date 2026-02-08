int minOperations(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int operations = 0;

    for (int j = 0; j < n; j++) {
        for (int i = 0; i < m; i++) {
            if (grid[i][j] != '0' + (j % 2 == 0 ? i % 2 : 1 - i % 2)) {
                operations++;
            }
        }
    }

    int alt_operations = 0;

    for (int j = 0; j < n; j++) {
        for (int i = 0; i < m; i++) {
            if (grid[i][j] != '0' + (j % 2 == 0 ? 1 - i % 2 : i % 2)) {
                alt_operations++;
            }
        }
    }

    return operations < alt_operations ? operations : alt_operations;
}