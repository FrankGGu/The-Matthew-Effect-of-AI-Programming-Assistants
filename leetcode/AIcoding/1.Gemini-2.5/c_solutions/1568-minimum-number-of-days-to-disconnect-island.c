#include <stdbool.h>
#include <string.h> // For memset, if using it for visited array

int R_global, C_global;
int** Grid_global;
bool visited_global[50][50]; // Max constraints 50x50

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

void dfs(int r, int c) {
    if (r < 0 || r >= R_global || c < 0 || c >= C_global || Grid_global[r][c] == 0 || visited_global[r][c]) {
        return;
    }
    visited_global[r][c] = true;
    for (int i = 0; i < 4; i++) {
        dfs(r + dr[i], c + dc[i]);
    }
}

int countIslands() {
    int islands = 0;
    // Reset visited array for each call to countIslands
    for (int i = 0; i < R_global; i++) {
        for (int j = 0; j < C_global; j++) {
            visited_global[i][j] = false;
        }
    }

    for (int i = 0; i < R_global; i++) {
        for (int j = 0; j < C_global; j++) {
            if (Grid_global[i][j] == 1 && !visited_global[i][j]) {
                islands++;
                dfs(i, j);
            }
        }
    }
    return islands;
}

int minDays(int** grid, int gridSize, int* gridColSize) {
    R_global = gridSize;
    C_global = gridColSize[0];
    Grid_global = grid; // Assign to global pointer

    // Case 0: Check initial state
    // If there are 0 or more than 1 islands, it's already disconnected (or no island exists).
    if (countIslands() != 1) {
        return 0;
    }

    // Case 1: Try removing one land cell
    // Iterate through each cell, temporarily change '1' to '0', and re-count islands.
    for (int r = 0; r < R_global; r++) {
        for (int c = 0; c < C_global; c++) {
            if (Grid_global[r][c] == 1) {
                Grid_global[r][c] = 0; // Temporarily remove land
                if (countIslands() != 1) {
                    Grid_global[r][c] = 1; // Backtrack
                    return 1;
                }
                Grid_global[r][c] = 1; // Backtrack
            }
        }
    }

    // Case 2: If neither 0 nor 1 day works, then 2 days are needed.
    // This is always possible (e.g., remove any two land cells).
    return 2;
}