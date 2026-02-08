#include <stdlib.h>

int countUnguarded(int m, int n, int** guards, int guardsSize, int* guardsColSize, int** walls, int wallsSize, int* wallsColSize) {
    int* grid_flat = (int*)malloc(m * n * sizeof(int));

    for (int i = 0; i < m * n; ++i) {
        grid_flat[i] = 0; // 0: empty
    }

    for (int i = 0; i < guardsSize; ++i) {
        int r = guards[i][0];
        int c = guards[i][1];
        grid_flat[r * n + c] = 1; // 1: guard
    }

    for (int i = 0; i < wallsSize; ++i) {
        int r = walls[i][0];
        int c = walls[i][1];
        grid_flat[r * n + c] = 2; // 2: wall
    }

    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            if (grid_flat[r * n + c] == 1) { // If it's a guard
                // Mark cells to the right
                for (int j = c + 1; j < n; ++j) {
                    if (grid_flat[r * n + j] == 1 || grid_flat[r * n + j] == 2) {
                        break; 
                    }
                    if (grid_flat[r * n + j] == 0) { // Only mark empty cells
                        grid_flat[r * n + j] = 3; // 3: guarded
                    }
                }

                // Mark cells to the left
                for (int j = c - 1; j >= 0; --j) {
                    if (grid_flat[r * n + j] == 1 || grid_flat[r * n + j] == 2) {
                        break;
                    }
                    if (grid_flat[r * n + j] == 0) {
                        grid_flat[r * n + j] = 3;
                    }
                }

                // Mark cells downwards
                for (int i = r + 1; i < m; ++i) {
                    if (grid_flat[i * n + c] == 1 || grid_flat[i * n + c] == 2) {
                        break;
                    }
                    if (grid_flat[i * n + c] == 0) {
                        grid_flat[i * n + c] = 3;
                    }
                }

                // Mark cells upwards
                for (int i = r - 1; i >= 0; --i) {
                    if (grid_flat[i * n + c] == 1 || grid_flat[i * n + c] == 2) {
                        break;
                    }
                    if (grid_flat[i * n + c] == 0) {
                        grid_flat[i * n + c] = 3;
                    }
                }
            }
        }
    }

    int unguarded_count = 0;
    for (int i = 0; i < m * n; ++i) {
        if (grid_flat[i] == 0) { // Count cells that are still empty
            unguarded_count++;
        }
    }

    free(grid_flat);

    return unguarded_count;
}