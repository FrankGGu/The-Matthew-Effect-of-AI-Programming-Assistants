#include <stdio.h>
#include <stdlib.h>

void dfs(char** grid, int rows, int cols, int i, int j) {
    if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] != '1') {
        return;
    }
    grid[i][j] = '0';
    dfs(grid, rows, cols, i + 1, j);
    dfs(grid, rows, cols, i - 1, j);
    dfs(grid, rows, cols, i, j + 1);
    dfs(grid, rows, cols, i, j - 1);
}

int numIslands(char** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == '1') {
                dfs(grid, rows, cols, i, j);
                count++;
            }
        }
    }
    return count;
}