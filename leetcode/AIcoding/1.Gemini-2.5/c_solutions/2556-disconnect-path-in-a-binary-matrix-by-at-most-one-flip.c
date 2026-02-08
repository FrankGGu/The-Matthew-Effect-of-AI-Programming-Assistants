#include <stdbool.h>
#include <stdlib.h> // For malloc/free

bool dfs(int r, int c, int m, int n, int** grid, bool** visited) {
    // Base cases for out of bounds, blocked cell, or already visited
    if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || visited[r][c]) {
        return false;
    }

    // If target reached
    if (r == m - 1 && c == n - 1) {
        return true;
    }

    // Mark current cell as visited
    visited[r][c] = true;

    // Try moving right or down
    bool found = dfs(r + 1, c, m, n, grid, visited) || dfs(r, c + 1, m, n, grid, visited);

    return found;
}

bool isPossibleToDisconnectPath(int** grid, int gridRowSize, int* gridColSize) {
    int m = gridRowSize;
    int n = gridColSize[0];

    // Allocate visited array once for the main function, and re-initialize for each DFS call.
    bool** visited = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        visited[i] = (bool*)malloc(n * sizeof(bool));
    }

    // --- Initial checks ---

    // Case 1: Start or end cell is 0. Path is already disconnected.
    if (grid[0][0] == 0 || grid[m - 1][n - 1] == 0) {
        // Free visited array before returning
        for (int i = 0; i < m; i++) {
            free(visited[i]);
        }
        free(visited);
        return true;
    }

    // Case 2: Check if any path exists at all in the original grid.
    // Reset visited for the initial DFS.
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = false;
        }
    }
    if (!dfs(0, 0, m, n, grid, visited)) {
        // No path exists initially, so it's already disconnected.
        // Free visited array before returning
        for (int i = 0; i < m; i++) {
            free(visited[i]);
        }
        free(visited);
        return true;
    }

    // --- Main logic: Try flipping one intermediate cell ---

    // Iterate through all possible intermediate cells to flip
    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            // Skip start, end, or already 0 cells
            // We only consider flipping '1's that are not the start or end points.
            if ((r == 0 && c == 0) || (r == m - 1 && c == n - 1) || grid[r][c] == 0) {
                continue;
            }

            // Temporarily flip the cell
            grid[r][c] = 0;

            // Reset visited array for the new DFS
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    visited[i][j] = false;
                }
            }

            // Check if a path still exists after flipping
            if (!dfs(0, 0, m, n, grid, visited)) {
                // If no path exists, we found a way to disconnect
                // Restore the grid cell before returning
                grid[r][c] = 1;
                // Free visited array
                for (int i = 0; i < m; i++) {
                    free(visited[i]);
                }
                free(visited);
                return true;
            }

            // Restore the grid cell for the next iteration
            grid[r][c] = 1;
        }
    }

    // If no single flip could disconnect the path, return false
    // Free visited array
    for (int i = 0; i < m; i++) {
        free(visited[i]);
    }
    free(visited);
    return false;
}