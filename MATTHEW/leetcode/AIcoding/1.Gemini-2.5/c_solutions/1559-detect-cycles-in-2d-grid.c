#include <stdbool.h>
#include <stdlib.h>

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

bool dfs(int r, int c, int pr, int pc, char target_char, char** grid, int m, int n, int** visited) {
    // Mark the current cell as currently visiting (in the recursion stack)
    visited[r][c] = 1;

    // Explore all 4 possible neighbors
    for (int i = 0; i < 4; i++) {
        int nr = r + dr[i];
        int nc = c + dc[i];

        // Check if the neighbor is within grid bounds
        if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
            continue;
        }

        // Check if the neighbor has the same character as the starting cell of the path
        if (grid[nr][nc] != target_char) {
            continue;
        }

        // Avoid going back to the immediate parent cell in the current path
        // This is crucial for cycle detection in undirected graphs to prevent trivial A-B-A paths
        if (nr == pr && nc == pc) {
            continue;
        }

        // If the neighbor is currently being visited (in the recursion stack),
        // it means we found a back edge to an ancestor, thus detecting a cycle.
        if (visited[nr][nc] == 1) {
            return true;
        }

        // If the neighbor is unvisited, recursively call DFS on it
        if (visited[nr][nc] == 0) {
            if (dfs(nr, nc, r, c, target_char, grid, m, n, visited)) {
                return true; // Cycle found in a deeper path
            }
        }
    }

    // Mark the current cell as fully visited (finished processing this node and its descendants)
    visited[r][c] = 2;
    return false; // No cycle found from this path
}

bool containsCycle(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    // Allocate and initialize the visited array
    // 0: unvisited
    // 1: visiting (currently in the DFS recursion stack)
    // 2: visited (finished processing, not in stack)
    int** visited = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        visited[i] = (int*)calloc(n, sizeof(int)); // calloc initializes all elements to 0
    }

    // Iterate through each cell in the grid
    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            // If the cell hasn't been visited yet, start a DFS from it
            if (visited[r][c] == 0) {
                // The initial parent for the starting cell is (-1, -1) as it has no parent
                if (dfs(r, c, -1, -1, grid[r][c], grid, m, n, visited)) {
                    // If DFS finds a cycle, immediately return true
                    // Free allocated memory before returning
                    for (int i = 0; i < m; i++) {
                        free(visited[i]);
                    }
                    free(visited);
                    return true;
                }
            }
        }
    }

    // If no cycle was found after checking all cells, free memory and return false
    for (int i = 0; i < m; i++) {
        free(visited[i]);
    }
    free(visited);

    return false;
}