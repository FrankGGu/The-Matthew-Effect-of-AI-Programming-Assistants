/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are stored in *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

void dfs(int** grid, int rows, int cols, int r, int c, int color, int original, int** visited) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] != original || visited[r][c]) {
        return;
    }

    visited[r][c] = 1;

    int isBorder = 0;

    if (r == 0 || r == rows - 1 || c == 0 || c == cols - 1) {
        isBorder = 1;
    } else {
        if (grid[r-1][c] != original && grid[r-1][c] != -1) isBorder = 1;
        if (grid[r+1][c] != original && grid[r+1][c] != -1) isBorder = 1;
        if (grid[r][c-1] != original && grid[r][c-1] != -1) isBorder = 1;
        if (grid[r][c+1] != original && grid[r][c+1] != -1) isBorder = 1;
    }

    if (isBorder) {
        grid[r][c] = -1;
    }

    dfs(grid, rows, cols, r-1, c, color, original, visited);
    dfs(grid, rows, cols, r+1, c, color, original, visited);
    dfs(grid, rows, cols, r, c-1, color, original, visited);
    dfs(grid, rows, cols, r, c+1, color, original, visited);
}

int** colorBorder(int** grid, int gridSize, int* gridColSize, int row, int col, int color, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)calloc(cols, sizeof(int));
    }

    int original = grid[row][col];

    dfs(grid, rows, cols, row, col, color, original, visited);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == -1) {
                grid[i][j] = color;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);

    *returnSize = gridSize;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    return grid;
}