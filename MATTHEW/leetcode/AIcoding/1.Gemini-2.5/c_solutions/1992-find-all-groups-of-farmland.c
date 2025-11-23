#include <stdlib.h> // For malloc, realloc

void dfs(int** grid, int rows, int cols, int r, int c, int* max_r, int* max_c) {
    // Base cases for DFS: out of bounds or not farmland
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
        return;
    }

    // Mark the current cell as visited by changing its value to 0
    grid[r][c] = 0;

    // Update the maximum row and column reached so far for this farmland group
    if (r > *max_r) {
        *max_r = r;
    }
    if (c > *max_c) {
        *max_c = c;
    }

    // Recursively call DFS for all four adjacent cells
    dfs(grid, rows, cols, r + 1, c, max_r, max_c); // Down
    dfs(grid, rows, cols, r - 1, c, max_r, max_c); // Up
    dfs(grid, rows, cols, r, c + 1, max_r, max_c); // Right
    dfs(grid, rows, cols, r, c - 1, max_r, max_c); // Left
}

int** findFarmland(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    if (rows == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }
    int cols = gridColSize[0]; // Assuming a rectangular grid, all columns have the same size

    // Initial capacity for the result array and its column sizes
    int capacity = 10; 
    int** result = (int**)malloc(capacity * sizeof(int*));
    *returnColumnSizes = (int*)malloc(capacity * sizeof(int));
    *returnSize = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            // If we find a piece of unvisited farmland
            if (grid[r][c] == 1) {
                int r1 = r; // Top-left row
                int c1 = c; // Top-left column
                int max_r = r; // Will store bottom-right row
                int max_c = c; // Will store bottom-right column

                // Perform DFS to find the extent of this farmland group
                dfs(grid, rows, cols, r, c, &max_r, &max_c);

                // Resize the result array if current capacity is reached
                if (*returnSize == capacity) {
                    capacity *= 2;
                    result = (int**)realloc(result, capacity * sizeof(int*));
                    *returnColumnSizes = (int*)realloc(*returnColumnSizes, capacity * sizeof(int));
                }

                // Allocate memory for the current farmland group's coordinates
                result[*returnSize] = (int*)malloc(4 * sizeof(int));
                result[*returnSize][0] = r1;
                result[*returnSize][1] = c1;
                result[*returnSize][2] = max_r;
                result[*returnSize][3] = max_c;

                // Each farmland group has 4 coordinates
                (*returnColumnSizes)[*returnSize] = 4;
                (*returnSize)++;
            }
        }
    }

    return result;
}