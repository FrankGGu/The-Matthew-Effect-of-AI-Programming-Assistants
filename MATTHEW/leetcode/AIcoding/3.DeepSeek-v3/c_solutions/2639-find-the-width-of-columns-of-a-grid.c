int* findColumnWidth(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int n = gridSize;
    int m = gridColSize[0];
    *returnSize = m;
    int* ans = malloc(m * sizeof(int));

    for (int j = 0; j < m; j++) {
        int maxWidth = 0;
        for (int i = 0; i < n; i++) {
            int num = grid[i][j];
            int width = 0;

            if (num <= 0) {
                width = 1;
                num = -num;
            }

            while (num > 0) {
                width++;
                num /= 10;
            }

            if (grid[i][j] < 0) {
                width++;
            }

            if (width > maxWidth) {
                maxWidth = width;
            }
        }
        ans[j] = maxWidth;
    }

    return ans;
}