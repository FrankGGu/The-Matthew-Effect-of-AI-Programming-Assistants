#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void dfs(int** grid, int rowSize, int colSize, int row, int col, int originalColor, int color, bool** visited, int* borderRows, int* borderCols, int* borderCount) {
    if (row < 0 || row >= rowSize || col < 0 || col >= colSize || grid[row][col] != originalColor || visited[row][col]) {
        return;
    }

    visited[row][col] = true;

    bool isBorder = false;
    if (row == 0 || row == rowSize - 1 || col == 0 || col == colSize - 1) {
        isBorder = true;
    } else if (grid[row - 1][col] != originalColor || grid[row + 1][col] != originalColor || grid[row][col - 1] != originalColor || grid[row][col + 1] != originalColor) {
        isBorder = true;
    }

    if (isBorder) {
        borderRows[*borderCount] = row;
        borderCols[*borderCount] = col;
        (*borderCount)++;
    }

    dfs(grid, rowSize, colSize, row + 1, col, originalColor, color, visited, borderRows, borderCols, borderCount);
    dfs(grid, rowSize, colSize, row - 1, col, originalColor, color, visited, borderRows, borderCols, borderCount);
    dfs(grid, rowSize, colSize, row, col + 1, originalColor, color, visited, borderRows, borderCols, borderCount);
    dfs(grid, rowSize, colSize, row, col - 1, originalColor, color, visited, borderRows, borderCols, borderCount);
}

int** colorBorder(int** grid, int gridSize, int* gridColSize, int row, int col, int color, int* returnSize, int** returnColumnSizes) {
    int rowSize = gridSize;
    int colSize = gridColSize[0];
    int originalColor = grid[row][col];

    bool** visited = (bool**)malloc(rowSize * sizeof(bool*));
    for (int i = 0; i < rowSize; i++) {
        visited[i] = (bool*)calloc(colSize, sizeof(bool));
    }

    int* borderRows = (int*)malloc(rowSize * colSize * sizeof(int));
    int* borderCols = (int*)malloc(rowSize * colSize * sizeof(int));
    int borderCount = 0;

    dfs(grid, rowSize, colSize, row, col, originalColor, color, visited, borderRows, borderCols, &borderCount);

    for (int i = 0; i < borderCount; i++) {
        grid[borderRows[i]][borderCols[i]] = color;
    }

    for (int i = 0; i < rowSize; i++) {
        free(visited[i]);
    }
    free(visited);
    free(borderRows);
    free(borderCols);

    *returnSize = gridSize;
    *returnColumnSizes = (int*)malloc(gridSize * sizeof(int));
    for (int i = 0; i < gridSize; i++) {
        (*returnColumnSizes)[i] = *gridColSize;
    }

    return grid;
}