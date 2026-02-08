#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numEnclaves(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int count = 0;

    bool visited[rows][cols];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 || visited[r][c]) {
            return;
        }

        visited[r][c] = true;

        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    for (int i = 0; i < rows; i++) {
        if (grid[i][0] == 1) {
            dfs(i, 0);
        }
        if (grid[i][cols - 1] == 1) {
            dfs(i, cols - 1);
        }
    }

    for (int j = 0; j < cols; j++) {
        if (grid[0][j] == 1) {
            dfs(0, j);
        }
        if (grid[rows - 1][j] == 1) {
            dfs(rows - 1, j);
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1 && !visited[i][j]) {
                count++;
            }
        }
    }

    return count;
}