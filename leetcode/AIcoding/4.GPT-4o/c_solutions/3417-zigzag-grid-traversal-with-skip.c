int* zigzagGridTraversal(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    if (gridSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int totalElements = gridSize * gridColSize[0];
    int* result = (int*)malloc(totalElements * sizeof(int));
    *returnSize = totalElements;

    int row = 0, col = 0, index = 0;
    int direction = 1; // 1 for down-right, -1 for up-left

    while (index < totalElements) {
        result[index++] = grid[row][col];

        if (direction == 1) {
            if (col == gridColSize[0] - 1) {
                row++;
                direction = -1;
            } else if (row == 0) {
                col++;
                direction = -1;
            } else {
                row--;
                col++;
            }
        } else {
            if (row == gridSize - 1) {
                col++;
                direction = 1;
            } else if (col == 0) {
                row++;
                direction = 1;
            } else {
                row++;
                col--;
            }
        }
    }

    return result;
}