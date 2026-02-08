#include <stdio.h>
#include <stdlib.h>

int numEnclaves(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    void dfs(int** grid, int i, int j) {
        if (i < 0 || j < 0 || i >= rows || j >= cols || grid[i][j] == 0)
            return;
        grid[i][j] = 0;
        dfs(grid, i + 1, j);
        dfs(grid, i - 1, j);
        dfs(grid, i, j + 1);
        dfs(grid, i, j - 1);
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if ((i == 0 || i == rows - 1 || j == 0 || j == cols - 1) && grid[i][j] == 1) {
                dfs(grid, i, j);
            }
        }
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1)
                count++;
        }
    }

    return count;
}