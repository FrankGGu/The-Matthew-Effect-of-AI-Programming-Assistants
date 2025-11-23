int gridGame(int** grid, int gridSize, int* gridColSize) {
    long long top = 0, bottom = 0;

    for (int j = 0; j < *gridColSize; j++) {
        top += grid[0][j];
    }

    long long minValue = LLONG_MAX;
    for (int j = 0; j < *gridColSize; j++) {
        top -= grid[0][j];
        bottom += grid[1][j];
        minValue = fmin(minValue, fmax(top, bottom));
    }

    return minValue;
}