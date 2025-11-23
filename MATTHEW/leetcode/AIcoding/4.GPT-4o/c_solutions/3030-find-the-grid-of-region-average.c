int** gridAverage(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(gridSize * sizeof(int*));
    *returnSize = gridSize;
    *returnColumnSizes = (int*)malloc(gridSize * sizeof(int));

    for (int i = 0; i < gridSize; i++) {
        result[i] = (int*)malloc(*gridColSize * sizeof(int));
        for (int j = 0; j < *gridColSize; j++) {
            int sum = 0, count = 0;
            for (int x = -1; x <= 1; x++) {
                for (int y = -1; y <= 1; y++) {
                    int ni = i + x, nj = j + y;
                    if (ni >= 0 && ni < gridSize && nj >= 0 && nj < *gridColSize) {
                        sum += grid[ni][nj];
                        count++;
                    }
                }
            }
            result[i][j] = sum / count;
        }
    }

    for (int i = 0; i < gridSize; i++) {
        (*returnColumnSizes)[i] = *gridColSize;
    }

    return result;
}