int* findBall(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (*gridColSize));
    *returnSize = *gridColSize;

    for (int j = 0; j < *gridColSize; j++) {
        int col = j;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][col] == 1) {
                if (col == *gridColSize - 1 || grid[i][col + 1] == -1) {
                    col = -1;
                    break;
                }
                col++;
            } else {
                if (col == 0 || grid[i][col - 1] == 1) {
                    col = -1;
                    break;
                }
                col--;
            }
        }
        result[j] = col;
    }

    return result;
}