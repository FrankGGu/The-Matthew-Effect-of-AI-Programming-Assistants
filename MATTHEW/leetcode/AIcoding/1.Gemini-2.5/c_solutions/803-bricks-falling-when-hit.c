#include <stdlib.h>
#include <string.h> // Required for memcpy

int* parent;
int* sz; // 'sz' is used instead of 'size' to avoid conflict with problem variable name
int R_global, C_global, CEILING_NODE_global;

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);

    if (root_i != root_j) {
        if (root_i == CEILING_NODE_global) {
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        } else if (root_j == CEILING_NODE_global) {
            parent[root_i] = root_j;
            sz[root_j] += sz[root_i];
        } else { // Neither is the ceiling node, merge by size
            if (sz[root_i] < sz[root_j]) { // Merge root_i into root_j
                parent[root_i] = root_j;
                sz[root_j] += sz[root_i];
            } else { // Merge root_j into root_i
                parent[root_j] = root_i;
                sz[root_i] += sz[root_j];
            }
        }
    }
}

int is_valid(int r, int c) {
    return r >= 0 && r < R_global && c >= 0 && c < C_global;
}

int* bricksFallingWhenHit(int** grid, int gridSize, int* gridColSize, int** hits, int hitsSize, int* hitsColSize, int* returnSize) {
    R_global = gridSize;
    C_global = gridColSize[0]; // Assuming all rows have the same number of columns

    int num_cells = R_global * C_global;
    CEILING_NODE_global = num_cells; // The index for the virtual ceiling node (one past the last cell index)

    // Allocate memory for DSU arrays
    parent = (int*)malloc((num_cells + 1) * sizeof(int));
    sz = (int*)malloc((num_cells + 1) * sizeof(int));

    // Create a temporary grid to simulate the state after all hits are applied initially
    int** temp_grid = (int**)malloc(R_global * sizeof(int*));
    for (int i = 0; i < R_global; i++) {
        temp_grid[i] = (int*)malloc(C_global * sizeof(int));
        memcpy(temp_grid[i], grid[i], C_global * sizeof(int)); // Copy row by row
    }

    // Store the original brick values at hit locations before modifying temp_grid
    int* original_brick_at_hit = (int*)malloc(hitsSize * sizeof(int));
    for (int k = 0; k < hitsSize; k++) {
        int r = hits[k][0];
        int c = hits[k][1];
        original_brick_at_hit[k] = temp_grid[r][c]; // Store original value (0 or 1)
        temp_grid[r][c] = 0; // Temporarily remove all bricks that will be hit
    }

    // Initialize DSU: each cell is its own set, ceiling node is its own set
    for (int i = 0; i <= CEILING_NODE_global; i++) {
        parent[i] = i;
        sz[i] = 1; // Each brick cell is initially a component of size 1
    }
    sz[CEILING_NODE_global] = 0; // The ceiling node itself doesn't count as a brick

    // Build the DSU structure based on the grid *after* all hits have been applied
    for (int r = 0; r < R_global; r++) {
        for (int c = 0; c < C_global; c++) {
            if (temp_grid[r][c] == 1) { // If there's a brick remaining
                int idx = r * C_global + c;
                if (r == 0) { // Bricks in the top row are connected to the ceiling
                    unite(idx, CEILING_NODE_global);
                }
                // Check and unite with active neighbors
                for (int i = 0; i < 4; i++) {
                    int nr = r + dr[i];
                    int nc = c + dc[i];
                    if (is_valid(nr, nc) && temp_grid[nr][nc] == 1) {
                        int neighbor_idx = nr * C_global + nc;
                        unite(idx, neighbor_idx);
                    }
                }
            }
        }
    }

    // Allocate memory for the results array
    int* ans = (int*)malloc(hitsSize * sizeof(int));
    *returnSize = hitsSize;

    // Process hits in reverse order
    for (int k = hitsSize - 1; k >= 0; k--) {
        int r = hits[k][0];
        int c = hits[k][1];

        if (original_brick_at_hit[k] == 0) {
            ans[k] = 0; // If there was no brick originally, no bricks fall
            continue;
        }

        // Get the number of bricks currently connected to the ceiling BEFORE adding this brick back
        int bricks_connected_to_ceiling_before_add = sz[find(CEILING_NODE_global)];

        // Add the brick back to the grid
        temp_grid[r][c] = 1;
        int idx = r * C_global + c;

        // Connect the newly added brick to its neighbors and/or the ceiling
        if (r == 0) { // If it's in the top row, connect to the ceiling
            unite(idx, CEILING_NODE_global);
        }
        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            if (is_valid(nr, nc) && temp_grid[nr][nc] == 1) {
                int neighbor_idx = nr * C_global + nc;
                unite(idx, neighbor_idx);
            }
        }

        // Get the number of bricks connected to the ceiling AFTER adding this brick back
        int bricks_connected_to_ceiling_after_add = sz[find(CEILING_NODE_global)];

        // The number of bricks that 'fell' due to this hit (when it was removed)
        // is the difference in ceiling-connected bricks, minus the brick itself (which didn't fall).
        int fallen = bricks_connected_to_ceiling_after_add - bricks_connected_to_ceiling_before_add - 1;
        ans[k] = (fallen > 0) ? fallen : 0; // Ensure non-negative result
    }

    // Free all dynamically allocated memory
    free(parent);
    free(sz);
    for (int i = 0; i < R_global; i++) {
        free(temp_grid[i]);
    }
    free(temp_grid);
    free(original_brick_at_hit);

    return ans; // The caller is responsible for freeing 'ans'
}