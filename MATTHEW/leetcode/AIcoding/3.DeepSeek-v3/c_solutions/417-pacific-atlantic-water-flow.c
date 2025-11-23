/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

void dfs(int** heights, int rows, int cols, int row, int col, int** visited) {
    visited[row][col] = 1;

    for (int i = 0; i < 4; i++) {
        int newRow = row + directions[i][0];
        int newCol = col + directions[i][1];

        if (newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols) {
            continue;
        }

        if (!visited[newRow][newCol] && heights[newRow][newCol] >= heights[row][col]) {
            dfs(heights, rows, cols, newRow, newCol, visited);
        }
    }
}

int** pacificAtlantic(int** heights, int heightsSize, int* heightsColSize, int* returnSize, int** returnColumnSizes) {
    if (heightsSize == 0 || heightsColSize[0] == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = heightsSize;
    int cols = heightsColSize[0];

    int** pacific = (int**)malloc(rows * sizeof(int*));
    int** atlantic = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        pacific[i] = (int*)calloc(cols, sizeof(int));
        atlantic[i] = (int*)calloc(cols, sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        dfs(heights, rows, cols, i, 0, pacific);
        dfs(heights, rows, cols, i, cols - 1, atlantic);
    }

    for (int j = 0; j < cols; j++) {
        dfs(heights, rows, cols, 0, j, pacific);
        dfs(heights, rows, cols, rows - 1, j, atlantic);
    }

    int** result = (int**)malloc(rows * cols * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * cols * sizeof(int));
    int count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (pacific[i][j] && atlantic[i][j]) {
                result[count] = (int*)malloc(2 * sizeof(int));
                result[count][0] = i;
                result[count][1] = j;
                (*returnColumnSizes)[count] = 2;
                count++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(pacific[i]);
        free(atlantic[i]);
    }
    free(pacific);
    free(atlantic);

    *returnSize = count;
    return result;
}