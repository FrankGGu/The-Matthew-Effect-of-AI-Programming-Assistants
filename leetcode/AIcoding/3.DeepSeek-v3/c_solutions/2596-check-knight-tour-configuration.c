bool checkValidGrid(int** grid, int gridSize, int* gridColSize) {
    if (grid[0][0] != 0) return false;

    int n = gridSize;
    int moves[8][2] = {{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 1}};

    int** positions = (int**)malloc(n * n * sizeof(int*));
    for (int i = 0; i < n * n; i++) {
        positions[i] = (int*)malloc(2 * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            positions[grid[i][j]][0] = i;
            positions[grid[i][j]][1] = j;
        }
    }

    for (int i = 0; i < n * n - 1; i++) {
        int dx = abs(positions[i+1][0] - positions[i][0]);
        int dy = abs(positions[i+1][1] - positions[i][1]);
        if (!((dx == 1 && dy == 2) || (dx == 2 && dy == 1))) {
            for (int j = 0; j < n * n; j++) {
                free(positions[j]);
            }
            free(positions);
            return false;
        }
    }

    for (int i = 0; i < n * n; i++) {
        free(positions[i]);
    }
    free(positions);
    return true;
}