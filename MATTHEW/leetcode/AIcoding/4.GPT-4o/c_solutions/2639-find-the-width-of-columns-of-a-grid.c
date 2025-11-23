int* findColumnWidth(char*** grid, int gridSize, int* gridColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (*gridColSize));
    *returnSize = *gridColSize;

    for (int j = 0; j < *gridColSize; j++) {
        int maxWidth = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] != NULL) {
                int len = strlen(grid[i][j]);
                if (len > maxWidth) {
                    maxWidth = len;
                }
            }
        }
        result[j] = maxWidth;
    }

    return result;
}