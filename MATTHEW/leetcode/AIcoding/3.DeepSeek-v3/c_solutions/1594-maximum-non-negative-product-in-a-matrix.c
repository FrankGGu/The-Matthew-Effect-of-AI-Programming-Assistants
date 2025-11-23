int maxProductPath(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    long long max[15][15];
    long long min[15][15];

    max[0][0] = min[0][0] = grid[0][0];

    for (int i = 1; i < rows; i++) {
        max[i][0] = min[i][0] = max[i-1][0] * grid[i][0];
    }

    for (int j = 1; j < cols; j++) {
        max[0][j] = min[0][j] = max[0][j-1] * grid[0][j];
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 1; j < cols; j++) {
            long long up_max = max[i-1][j] * grid[i][j];
            long long left_max = max[i][j-1] * grid[i][j];
            long long up_min = min[i-1][j] * grid[i][j];
            long long left_min = min[i][j-1] * grid[i][j];

            max[i][j] = fmaxl(fmaxl(up_max, left_max), fmaxl(up_min, left_min));
            min[i][j] = fminl(fminl(up_max, left_max), fminl(up_min, left_min));
        }
    }

    long long result = max[rows-1][cols-1];
    if (result < 0) {
        return -1;
    }
    return result % 1000000007;
}