#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rows, cols;
int** grid_global;

void dfs(int row, int col, bool** visited) {
    if (row < 0 || row >= rows || col < 0 || col >= cols || grid_global[row][col] == 0 || visited[row][col]) {
        return;
    }
    visited[row][col] = true;
    dfs(row + 1, col, visited);
    dfs(row - 1, col, visited);
    dfs(row, col + 1, visited);
    dfs(row, col - 1, visited);
}

int count_islands() {
    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)malloc(cols * sizeof(bool));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    int island_count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid_global[i][j] == 1 && !visited[i][j]) {
                dfs(i, j, visited);
                island_count++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);

    return island_count;
}

int minDays(int** grid, int gridSize, int* gridColSize) {
    rows = gridSize;
    cols = *gridColSize;
    grid_global = grid;

    int initial_islands = count_islands();

    if (initial_islands == 0 || initial_islands > 1) {
        return 0;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int temp = grid[i][j];
                grid[i][j] = 0;
                if (count_islands() != 1) {
                    return 1;
                }
                grid[i][j] = temp;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                for(int k = 0; k < rows; k++){
                    for(int l = 0; l < cols; l++){
                        if(grid[k][l] == 1 && (i != k || j != l)){
                            int temp1 = grid[i][j];
                            int temp2 = grid[k][l];
                            grid[i][j] = 0;
                            grid[k][l] = 0;
                            if(count_islands() != 1){
                                return 2;
                            }
                            grid[i][j] = temp1;
                            grid[k][l] = temp2;
                        }
                    }
                }
            }
        }
    }

    return 2;
}