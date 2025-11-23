#include <stdio.h>
#include <stdlib.h>

int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize) {
    int max_area = 0;
    int rows = gridSize;
    int cols = *gridColSize;

    int dfs(int** grid, int i, int j, int rows, int cols) {
        if (i < 0 || j < 0 || i >= rows || j >= cols || grid[i][j] == 0) {
            return 0;
        }
        grid[i][j] = 0;
        int area = 1;
        area += dfs(grid, i + 1, j, rows, cols);
        area += dfs(grid, i - 1, j, rows, cols);
        area += dfs(grid, i, j + 1, rows, cols);
        area += dfs(grid, i, j - 1, rows, cols);
        return area;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int area = dfs(grid, i, j, rows, cols);
                if (area > max_area) {
                    max_area = area;
                }
            }
        }
    }

    return max_area;
}