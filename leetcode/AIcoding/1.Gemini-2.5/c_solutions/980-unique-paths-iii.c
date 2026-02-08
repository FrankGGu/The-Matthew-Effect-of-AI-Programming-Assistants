#include <stdlib.h> // For malloc, free (though not strictly needed for this solution as grid is passed)

int g_rows;
int g_cols;
int g_total_zeros; // Count of '0' cells
int g_unique_paths; // Final count of unique paths

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

void dfs(int r, int c, int count_visited_cells, int** grid) {
    // Base cases for recursion

    // 1. Out of bounds
    if (r < 0 || r >= g_rows || c < 0 || c >= g_cols) {
        return;
    }

    // 2. Obstacle (-1) or already visited (-2)
    if (grid[r][c] == -1 || grid[r][c] == -2) {
        return;
    }

    // 3. Reached the end cell (2)
    if (grid[r][c] == 2) {
        // Check if all non-obstacle squares (including start and all zeros) have been visited
        // g_total_zeros is the count of '0's. We also need to count the '1' (start) cell.
        // So, if count_visited_cells (which counts '1' and '0's) equals g_total_zeros + 1,
        // it means all required cells were visited before reaching '2'.
        if (count_visited_cells == g_total_zeros + 1) {
            g_unique_paths++;
        }
        return;
    }

    // Recursive step

    // Store original value for backtracking
    int original_val = grid[r][c];

    // Mark current cell as visited (-2)
    grid[r][c] = -2;

    // Increment count of visited non-obstacle cells (this cell is either '0' or '1')
    count_visited_cells++;

    // Explore all four directions
    for (int i = 0; i < 4; i++) {
        dfs(r + dr[i], c + dc[i], count_visited_cells, grid);
    }

    // Backtrack: restore the cell's original value
    grid[r][c] = original_val;
    // No need to decrement count_visited_cells as it's passed by value
}

int uniquePathsIII(int** grid, int gridSize, int* gridColSize) {
    g_rows = gridSize;
    g_cols = gridColSize[0]; // Assuming all rows have the same number of columns

    int start_r = -1, start_c = -1;
    g_total_zeros = 0;
    g_unique_paths = 0;

    // First pass to find start coordinates and count total empty cells ('0')
    for (int i = 0; i < g_rows; i++) {
        for (int j = 0; j < g_cols; j++) {
            if (grid[i][j] == 1) {
                start_r = i;
                start_c = j;
            } else if (grid[i][j] == 0) {
                g_total_zeros++;
            }
        }
    }

    // Start DFS from the '1' cell.
    // Initial count_visited_cells is 0, as the start cell itself will be counted
    // within the first DFS call.
    dfs(start_r, start_c, 0, grid);

    return g_unique_paths;
}