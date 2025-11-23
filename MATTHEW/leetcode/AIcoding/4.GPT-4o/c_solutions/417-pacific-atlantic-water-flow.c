int** pacificAtlantic(int** heights, int heightsSize, int* heightsColSize, int* returnSize, int** returnColumnSizes) {
    int rows = heightsSize, cols = heightsColSize[0];
    bool** pacific = (bool**)malloc(rows * sizeof(bool*));
    bool** atlantic = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        pacific[i] = (bool*)calloc(cols, sizeof(bool));
        atlantic[i] = (bool*)calloc(cols, sizeof(bool));
    }

    void dfs(int** heights, bool** ocean, int x, int y, int rows, int cols) {
        ocean[x][y] = true;
        int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        for (int i = 0; i < 4; i++) {
            int nx = x + directions[i][0], ny = y + directions[i][1];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !ocean[nx][ny] && heights[nx][ny] >= heights[x][y]) {
                dfs(heights, ocean, nx, ny, rows, cols);
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        dfs(heights, pacific, i, 0, rows, cols);
        dfs(heights, atlantic, i, cols - 1, rows, cols);
    }
    for (int j = 0; j < cols; j++) {
        dfs(heights, pacific, 0, j, rows, cols);
        dfs(heights, atlantic, rows - 1, j, rows, cols);
    }

    int** result = (int**)malloc(rows * cols * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * cols * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (pacific[i][j] && atlantic[i][j]) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = i;
                result[*returnSize][1] = j;
                (*returnSize)++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(pacific[i]);
        free(atlantic[i]);
    }
    free(pacific);
    free(atlantic);

    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}