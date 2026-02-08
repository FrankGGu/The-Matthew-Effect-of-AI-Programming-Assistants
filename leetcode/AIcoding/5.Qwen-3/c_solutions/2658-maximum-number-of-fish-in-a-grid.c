#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(int** grid, int row, int col, int rows, int cols, int** visited) {
    if (row < 0 || col < 0 || row >= rows || col >= cols || grid[row][col] == 0 || visited[row][col]) {
        return 0;
    }
    visited[row][col] = 1;
    int fish = grid[row][col];
    fish += dfs(grid, row + 1, col, rows, cols, visited);
    fish += dfs(grid, row - 1, col, rows, cols, visited);
    fish += dfs(grid, row, col + 1, rows, cols, visited);
    fish += dfs(grid, row, col - 1, rows, cols, visited);
    return fish;
}

int maxFish(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)calloc(cols, sizeof(int));
    }
    int maxFish = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] != 0 && !visited[i][j]) {
                int currentFish = dfs(grid, i, j, rows, cols, visited);
                maxFish = max(maxFish, currentFish);
            }
        }
    }
    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    return maxFish;
}