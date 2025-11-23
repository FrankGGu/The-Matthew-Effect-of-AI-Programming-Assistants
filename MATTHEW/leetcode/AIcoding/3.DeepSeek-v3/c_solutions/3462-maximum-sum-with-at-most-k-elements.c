int maxSum(int** grid, int gridSize, int* gridColSize, int k, int* xCoordinates, int xCoordinatesSize, int* yCoordinates, int yCoordinatesSize) {
    int m = gridSize;
    int n = gridColSize[0];

    long long** prefix = (long long**)malloc((m + 1) * sizeof(long long*));
    for (int i = 0; i <= m; i++) {
        prefix[i] = (long long*)calloc(n + 1, sizeof(long long));
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            prefix[i][j] = grid[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
        }
    }

    long long* sums = (long long*)malloc(m * n * sizeof(long long));
    int idx = 0;

    for (int i = 0; i <= m - 3; i++) {
        for (int j = 0; j <= n - 3; j++) {
            long long sum = prefix[i + 3][j + 3] - prefix[i][j + 3] - prefix[i + 3][j] + prefix[i][j];
            sum -= (grid[i + 1][j] + grid[i + 1][j + 2]);
            sums[idx++] = sum;
        }
    }

    for (int i = 0; i < xCoordinatesSize; i++) {
        int x = xCoordinates[i];
        int y = yCoordinates[i];
        sums[idx++] = grid[x][y];
    }

    qsort(sums, idx, sizeof(long long), [](const void* a, const void* b) {
        long long aa = *(long long*)a;
        long long bb = *(long long*)b;
        return (aa < bb) - (aa > bb);
    });

    long long result = 0;
    int count = 0;
    for (int i = idx - 1; i >= 0 && count < k; i--, count++) {
        result += sums[i];
    }

    for (int i = 0; i <= m; i++) {
        free(prefix[i]);
    }
    free(prefix);
    free(sums);

    return result;
}