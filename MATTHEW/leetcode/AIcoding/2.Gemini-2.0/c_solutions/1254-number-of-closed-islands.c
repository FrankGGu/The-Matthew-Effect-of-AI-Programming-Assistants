#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int closedIsland(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize;
    int cols = gridColSize[0];
    int count = 0;

    bool isValid(int r, int c) {
        return r >= 0 && r < rows && c >= 0 && c < cols;
    }

    void dfs(int r, int c) {
        if (!isValid(r, c) || grid[r][c] == 1) {
            return;
        }

        grid[r][c] = 1;

        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if ((i == 0 || i == rows - 1 || j == 0 || j == cols - 1) && grid[i][j] == 0) {
                dfs(i, j);
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0) {
                count++;
                dfs(i, j);
            }
        }
    }

    return count;
}