#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dfs(int** grid, int gridSize, int* gridColSize, int row, int col) {
    if (row < 0 || row >= gridSize || col < 0 || col >= gridColSize[row] || grid[row][col] == 0) {
        return 0;
    }

    int fish = grid[row][col];
    grid[row][col] = 0; 

    fish += dfs(grid, gridSize, gridColSize, row + 1, col);
    fish += dfs(grid, gridSize, gridColSize, row - 1, col);
    fish += dfs(grid, gridSize, gridColSize, row, col + 1);
    fish += dfs(grid, gridSize, gridColSize, row, col - 1);

    return fish;
}

int findMaxFish(int** grid, int gridSize, int* gridColSize) {
    int maxFish = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > 0) {
                int fish = dfs(grid, gridSize, gridColSize, i, j);
                if (fish > maxFish) {
                    maxFish = fish;
                }
            }
        }
    }
    return maxFish;
}