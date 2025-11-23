#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int n;

int dfs(int** grid, int i, int j, int color) {
    if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] != 1) {
        return 0;
    }
    grid[i][j] = color;
    return 1 + dfs(grid, i + 1, j, color) + dfs(grid, i - 1, j, color) +
           dfs(grid, i, j + 1, color) + dfs(grid, i, j - 1, color);
}

int largestIsland(int** grid, int gridSize, int* gridColSize) {
    n = gridSize;
    int color = 2;
    int* areas = (int*)malloc((n * n + 2) * sizeof(int));
    for (int i = 0; i < n * n + 2; i++) {
        areas[i] = 0;
    }
    int maxArea = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                areas[color] = dfs(grid, i, j, color);
                maxArea = (areas[color] > maxArea) ? areas[color] : maxArea;
                color++;
            }
        }
    }

    int result = maxArea;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) {
                int up = (i > 0) ? grid[i - 1][j] : 0;
                int down = (i < n - 1) ? grid[i + 1][j] : 0;
                int left = (j > 0) ? grid[i][j - 1] : 0;
                int right = (j < n - 1) ? grid[i][j + 1] : 0;

                int area = 1;
                int colors[4] = {up, down, left, right};
                int seen[n * n + 2];
                for (int k = 0; k < n * n + 2; k++) seen[k] = 0;

                for (int k = 0; k < 4; k++) {
                    if (colors[k] > 1 && seen[colors[k]] == 0) {
                        area += areas[colors[k]];
                        seen[colors[k]] = 1;
                    }
                }
                result = (area > result) ? area : result;
            }
        }
    }

    free(areas);
    return result;
}