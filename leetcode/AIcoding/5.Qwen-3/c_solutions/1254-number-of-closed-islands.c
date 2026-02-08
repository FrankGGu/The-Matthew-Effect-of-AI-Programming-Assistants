#include <stdio.h>
#include <stdlib.h>

int** create2DArray(int rows, int cols) {
    int** arr = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        arr[i] = (int*)malloc(cols * sizeof(int));
    }
    return arr;
}

void free2DArray(int** arr, int rows) {
    for (int i = 0; i < rows; i++) {
        free(arr[i]);
    }
    free(arr);
}

void dfs(int** grid, int rows, int cols, int row, int col) {
    if (row < 0 || col < 0 || row >= rows || col >= cols || grid[row][col] != 0) {
        return;
    }
    grid[row][col] = 1;
    dfs(grid, rows, cols, row + 1, col);
    dfs(grid, rows, cols, row - 1, col);
    dfs(grid, rows, cols, row, col + 1);
    dfs(grid, rows, cols, row, col - 1);
}

int closedIsland(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if ((i == 0 || i == rows - 1 || j == 0 || j == cols - 1) && grid[i][j] == 0) {
                dfs(grid, rows, cols, i, j);
            }
        }
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0) {
                dfs(grid, rows, cols, i, j);
                count++;
            }
        }
    }

    return count;
}