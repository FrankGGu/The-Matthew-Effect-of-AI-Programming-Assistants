int* getDifferences(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    *returnSize = gridSize + *gridColSize;
    int* result = (int*)malloc((*returnSize) * sizeof(int));
    int rowDiff, colDiff;

    for (int i = 0; i < gridSize; i++) {
        rowDiff = 0;
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == 0) rowDiff++;
            else rowDiff--;
        }
        result[i] = rowDiff;
    }

    for (int j = 0; j < *gridColSize; j++) {
        colDiff = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] == 0) colDiff++;
            else colDiff--;
        }
        result[gridSize + j] = colDiff;
    }

    return result;
}