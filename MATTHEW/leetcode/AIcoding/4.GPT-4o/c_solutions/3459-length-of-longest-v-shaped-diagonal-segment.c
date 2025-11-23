int longestVShapedDiagonal(int** grid, int gridSize, int* gridColSize) {
    int maxLength = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 1) {
                int length = 1;
                int x = i + 1, y = j - 1;
                while (x < gridSize && y >= 0 && grid[x][y] == 1) {
                    length++;
                    x++;
                    y--;
                }
                x = i + 1;
                y = j + 1;
                while (x < gridSize && y < gridColSize[x] && grid[x][y] == 1) {
                    length++;
                    x++;
                    y++;
                }
                maxLength = (length > maxLength) ? length : maxLength;
            }
        }
    }
    return maxLength;
}