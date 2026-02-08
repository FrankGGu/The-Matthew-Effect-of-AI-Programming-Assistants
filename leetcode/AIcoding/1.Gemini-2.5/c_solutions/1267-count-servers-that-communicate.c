int countServers(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return 0;
    }

    int m = gridSize;
    int n = gridColSize[0];

    int row_counts[m];
    int col_counts[n];

    for (int i = 0; i < m; ++i) {
        row_counts[i] = 0;
    }
    for (int j = 0; j < n; ++j) {
        col_counts[j] = 0;
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (grid[i][j] == 1) {
                row_counts[i]++;
                col_counts[j]++;
            }
        }
    }

    int communicating_servers_count = 0;
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (grid[i][j] == 1) {
                if (row_counts[i] > 1 || col_counts[j] > 1) {
                    communicating_servers_count++;
                }
            }
        }
    }

    return communicating_servers_count;
}