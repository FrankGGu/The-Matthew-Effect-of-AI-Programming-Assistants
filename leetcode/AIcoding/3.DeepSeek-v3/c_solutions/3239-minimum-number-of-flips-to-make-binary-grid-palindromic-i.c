int minFlips(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int res = 0;

    for (int i = 0; i < rows; i++) {
        int left = 0, right = cols - 1;
        while (left < right) {
            if (grid[i][left] != grid[i][right]) {
                res++;
            }
            left++;
            right--;
        }
    }

    for (int j = 0; j < cols; j++) {
        int top = 0, bottom = rows - 1;
        while (top < bottom) {
            if (grid[top][j] != grid[bottom][j]) {
                res++;
            }
            top++;
            bottom--;
        }
    }

    return res / 2;
}