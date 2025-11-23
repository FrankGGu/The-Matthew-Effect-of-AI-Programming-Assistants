#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(int** grid, int rows, int cols, int i, int j) {
    if (i < 0 || j < 0 || i >= rows || j >= cols || grid[i][j] == 0) {
        return 0;
    }
    int temp = grid[i][j];
    grid[i][j] = 0;
    int maxGold = 0;
    maxGold = max(maxGold, dfs(grid, rows, cols, i + 1, j));
    maxGold = max(maxGold, dfs(grid, rows, cols, i - 1, j));
    maxGold = max(maxGold, dfs(grid, rows, cols, i, j + 1));
    maxGold = max(maxGold, dfs(grid, rows, cols, i, j - 1));
    grid[i][j] = temp;
    return maxGold + temp;
}

int getMaximumGold(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int maxGold = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] != 0) {
                maxGold = max(maxGold, dfs(grid, rows, cols, i, j));
            }
        }
    }
    return maxGold;
}