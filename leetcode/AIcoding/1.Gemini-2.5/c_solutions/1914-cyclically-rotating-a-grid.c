#include <stdlib.h> // For malloc

int** rotateGrid(int** grid, int gridSize, int* gridColSize, int k, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    // Max layer size: 2 * (m + n) - 4. For m=300, n=300, max size is 2*(300+300)-4 = 1196.
    // Using fixed-size arrays on the stack for temporary storage.
    int layer_elements[1200]; 
    int rotated_elements[1200];

    int r_s = 0; // current layer's starting row index
    int r_e = m - 1; // current layer's ending row index
    int c_s = 0; // current layer's starting column index
    int c_e = n - 1; // current layer's ending column index

    // Iterate through layers from outermost to innermost
    while (r_s <= r_e && c_s <= c_e) {
        int current_idx = 0;

        // 1. Collect elements for the current layer in clockwise order
        // Top row: from (r_s, c_s) to (r_s, c_e)
        for (int j = c_s; j <= c_e; j++) {
            layer_elements[current_idx++] = grid[r_s][j];
        }
        // Right column: from (r_s+1, c_e) to (r_e, c_e)
        for (int i = r_s + 1; i <= r_e; i++) {
            layer_elements[current_idx++] = grid[i][c_e];
        }
        // Bottom row: from (r_e, c_e-1) to (r_e, c_s)
        // Only if it's a distinct row from the top row
        if (r_s != r_e) {
            for (int j = c_e - 1; j >= c_s; j--) {
                layer_elements[current_idx++] = grid[r_e][j];
            }
        }
        // Left column: from (r_e-1, c_s) to (r_s+1, c_s)
        // Only if it's a distinct column from the right column
        if (c_s != c_e) {
            for (int i = r_e - 1; i >= r_s + 1; i--) {
                layer_elements[current_idx++] = grid[i][c_s];
            }
        }

        int layer_size = current_idx;
        if (layer_size == 0) { // Should not happen if r_s <= r_e && c_s <= c_e holds, but a safety check
            break;
        }

        // 2. Calculate effective rotation and apply it to the collected elements
        int effective_k = k % layer_size;
        for (int i = 0; i < layer_size; i++) {
            rotated_elements[i] = layer_elements[(i + effective_k) % layer_size];
        }

        // 3. Place the rotated elements back into the grid in the same clockwise order
        current_idx = 0;
        // Top row
        for (int j = c_s; j <= c_e; j++) {
            grid[r_s][j] = rotated_elements[current_idx++];
        }
        // Right column
        for (int i = r_s + 1; i <= r_e; i++) {
            grid[i][c_e] = rotated_elements[current_idx++];
        }
        // Bottom row
        if (r_s != r_e) {
            for (int j = c_e - 1; j >= c_s; j--) {
                grid[r_e][j] = rotated_elements[current_idx++];
            }
        }
        // Left column
        if (c_s != c_e) {
            for (int i = r_e - 1; i >= r_s + 1; i--) {
                grid[i][c_s] = rotated_elements[current_idx++];
            }
        }

        // Move to the next inner layer
        r_s++;
        r_e--;
        c_s++;
        c_e--;
    }

    // LeetCode specific return values for in-place modification
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }
    return grid; // Return the modified grid
}