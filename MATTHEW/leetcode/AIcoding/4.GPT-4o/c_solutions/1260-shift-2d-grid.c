int** shiftGrid(int** grid, int gridRowSize, int gridColSize, int k, int* returnSize, int** returnColumnSizes) {
    *returnSize = gridRowSize;
    *returnColumnSizes = (int*)malloc(sizeof(int) * gridRowSize);
    for (int i = 0; i < gridRowSize; i++) {
        (*returnColumnSizes)[i] = gridColSize;
    }

    int totalElements = gridRowSize * gridColSize;
    k = k % totalElements;

    int** result = (int**)malloc(sizeof(int*) * gridRowSize);
    for (int i = 0; i < gridRowSize; i++) {
        result[i] = (int*)malloc(sizeof(int) * gridColSize);
    }

    for (int i = 0; i < gridRowSize; i++) {
        for (int j = 0; j < gridColSize; j++) {
            int newIdx = (i * gridColSize + j + k) % totalElements;
            result[newIdx / gridColSize][newIdx % gridColSize] = grid[i][j];
        }
    }

    return result;
}