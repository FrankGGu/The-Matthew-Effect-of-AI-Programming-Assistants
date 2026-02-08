int** largestLocal(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int n = gridSize - 2;
    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            int maxVal = 0;
            for (int x = 0; x < 3; x++) {
                for (int y = 0; y < 3; y++) {
                    maxVal = fmax(maxVal, grid[i + x][j + y]);
                }
            }
            result[i][j] = maxVal;
        }
        (*returnColumnSizes)[i] = n;
    }
    return result;
}