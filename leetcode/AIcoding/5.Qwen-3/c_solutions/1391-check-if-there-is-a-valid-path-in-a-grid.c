#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int row;
    int col;
} Pair;

bool dfs(int** grid, int rows, int cols, int** visited, int row, int col) {
    if (row == rows - 1 && col == cols - 1) return true;
    visited[row][col] = 1;
    int directions[4][2] = {{-1,0}, {1,0}, {0,-1}, {0,1}};
    int type = grid[row][col];
    for (int i = 0; i < 4; i++) {
        int new_row = row + directions[i][0];
        int new_col = col + directions[i][1];
        if (new_row >= 0 && new_row < rows && new_col >= 0 && new_col < cols && !visited[new_row][new_col]) {
            int next_type = grid[new_row][new_col];
            if ((i == 0 && (next_type == 2 || next_type == 3 || next_type == 5)) ||
                (i == 1 && (next_type == 1 || next_type == 4 || next_type == 6)) ||
                (i == 2 && (next_type == 1 || next_type == 3 || next_type == 5)) ||
                (i == 3 && (next_type == 2 || next_type == 4 || next_type == 6))) {
                if (dfs(grid, rows, cols, visited, new_row, new_col)) return true;
            }
        }
    }
    return false;
}

bool hasValidPath(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)calloc(cols, sizeof(int));
    }
    bool result = dfs(grid, rows, cols, visited, 0, 0);
    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited);
    return result;
}