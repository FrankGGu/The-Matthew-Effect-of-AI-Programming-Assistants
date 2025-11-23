#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubIslands(int** grid1, int gridSize1, int* gridColSize1, int** grid2, int gridSize2, int* gridColSize2) {
    int rows = gridSize1;
    int cols = gridColSize1[0];
    int count = 0;

    bool isValid(int r, int c) {
        return r >= 0 && r < rows && c >= 0 && c < cols;
    }

    void dfs(int r, int c) {
        if (!isValid(r, c) || grid2[r][c] == 0) {
            return;
        }

        grid2[r][c] = 0; 

        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (grid1[r][c] == 0 && grid2[r][c] == 1) {
                dfs(r, c);
            }
        }
    }

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (grid2[r][c] == 1) {
                count++;
                dfs(r, c);
            }
        }
    }

    return count;
}