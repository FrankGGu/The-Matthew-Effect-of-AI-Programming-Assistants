#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool dfs(char** grid, int row, int col, int parentRow, int parentCol, int rows, int cols, bool** visited) {
    visited[row][col] = true;

    int dr[] = {0, 0, 1, -1};
    int dc[] = {1, -1, 0, 0};

    for (int i = 0; i < 4; i++) {
        int newRow = row + dr[i];
        int newCol = col + dc[i];

        if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == grid[row][col]) {
            if (!visited[newRow][newCol]) {
                if (dfs(grid, newRow, newCol, row, col, rows, cols, visited)) {
                    return true;
                }
            } else if (newRow != parentRow || newCol != parentCol) {
                return true;
            }
        }
    }

    return false;
}

bool containsCycle(char** grid, int rows, int cols) {
    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)malloc(cols * sizeof(bool));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (!visited[i][j]) {
                if (dfs(grid, i, j, -1, -1, rows, cols, visited)) {
                    for (int k = 0; k < rows; k++) {
                        free(visited[k]);
                    }
                    free(visited);
                    return true;
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    return false;
}