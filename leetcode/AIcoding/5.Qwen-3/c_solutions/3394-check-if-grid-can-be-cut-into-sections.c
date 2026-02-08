#include <stdio.h>
#include <stdlib.h>

bool** createGrid(int rows, int cols) {
    bool** grid = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        grid[i] = (bool*)malloc(cols * sizeof(bool));
    }
    return grid;
}

void freeGrid(bool** grid, int rows) {
    for (int i = 0; i < rows; i++) {
        free(grid[i]);
    }
    free(grid);
}

bool dfs(bool** grid, int** visited, int rows, int cols, int r, int c, int target) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] || grid[r][c] != target) {
        return false;
    }
    visited[r][c] = 1;
    bool up = dfs(grid, visited, rows, cols, r - 1, c, target);
    bool down = dfs(grid, visited, rows, cols, r + 1, c, target);
    bool left = dfs(grid, visited, rows, cols, r, c - 1, target);
    bool right = dfs(grid, visited, rows, cols, r, c + 1, target);
    return up || down || left || right;
}

bool checkValidGrid(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    bool** visited = createGrid(rows, cols);
    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (!visited[i][j]) {
                count++;
                if (count > 1) {
                    freeGrid(visited, rows);
                    return false;
                }
                dfs(grid, visited, rows, cols, i, j, grid[i][j]);
            }
        }
    }
    freeGrid(visited, rows);
    return true;
}