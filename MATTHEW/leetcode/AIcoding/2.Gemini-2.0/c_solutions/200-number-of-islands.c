#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void dfs(char** grid, int gridSize, int* gridColSize, int i, int j) {
    if (i < 0 || i >= gridSize || j < 0 || j >= gridColSize[0] || grid[i][j] == '0') {
        return;
    }

    grid[i][j] = '0';
    dfs(grid, gridSize, gridColSize, i + 1, j);
    dfs(grid, gridSize, gridColSize, i - 1, j);
    dfs(grid, gridSize, gridColSize, i, j + 1);
    dfs(grid, gridSize, gridColSize, i, j - 1);
}

int numIslands(char** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0) {
        return 0;
    }

    int numIslands = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] == '1') {
                numIslands++;
                dfs(grid, gridSize, gridColSize, i, j);
            }
        }
    }

    return numIslands;
}