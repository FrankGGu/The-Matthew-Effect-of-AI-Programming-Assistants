#include <stdio.h>
#include <stdlib.h>

int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize) {
    int maxArea = 0;
    int rows = gridSize;
    int cols = *gridColSize;

    int dfs(int i, int j, int** grid, int rows, int cols) {
        if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] == 0) {
            return 0;
        }
        grid[i][j] = 0;
        int area = 1;
        area += dfs(i + 1, j, grid, rows, cols);
        area += dfs(i - 1, j, grid, rows, cols);
        area += dfs(i, j + 1, grid, rows, cols);
        area += dfs(i, j - 1, grid, rows, cols);
        return area;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int area = dfs(i, j, grid, rows, cols);
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }

    return maxArea;
}