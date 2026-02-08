long long gridGame(int** grid, int gridSize, int* gridColSize) {
    int n = gridColSize[0];
    long long topSum = 0;
    for (int i = 0; i < n; i++) {
        topSum += grid[0][i];
    }

    long long bottomSum = 0;
    long long result = LLONG_MAX;

    for (int i = 0; i < n; i++) {
        topSum -= grid[0][i];
        long long maxPoints = (topSum > bottomSum) ? topSum : bottomSum;
        if (maxPoints < result) {
            result = maxPoints;
        }
        bottomSum += grid[1][i];
    }

    return result;
}