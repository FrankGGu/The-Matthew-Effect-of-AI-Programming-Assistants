#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

int get_final_cell_value(int R, int C, int initial_grid[R][C], int flips[R][C], int r, int c) {
    int val = initial_grid[r][c];

    // Apply flip at (r,c)
    val ^= flips[r][c];

    // Apply flips from neighbors
    if (r > 0) val ^= flips[r - 1][c];
    if (r < R - 1) val ^= flips[r + 1][c];
    if (c > 0) val ^= flips[r][c - 1];
    if (c < C - 1) val ^= flips[r][c + 1];

    return val;
}

int minFlips(int** grid, int gridSize, int* gridColSize) {
    int R = gridSize;
    int C = gridColSize[0];

    int initial_grid[R][C];
    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            initial_grid[i][j] = grid[i][j];
        }
    }

    int min_total_flips = INT_MAX;

    // Iterate through all possible flip configurations for the first row.
    // There are 2^C configurations.
    for (int first_row_mask = 0; first_row_mask < (1 << C); first_row_mask++) {
        int current_flips[R][C];
        memset(current_flips, 0, sizeof(current_flips));
        int current_total_flips = 0;

        // Apply flips for the first row based on the mask.
        for (int j = 0; j < C; j++) {
            if ((first_row_mask >> j) & 1) {
                current_flips[0][j] = 1;
                current_total_flips++;
            }
        }

        // `temp_sim_grid` simulates the grid state. It tracks the value of cells
        // as if we were trying to make them zero using the "Lights Out" propagation.
        int temp_sim_grid[R][C];
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                temp_sim_grid[i][j] = initial_grid[i][j];
            }
        }

        // Apply first row flips to `temp_sim_grid` to see their immediate effect.
        // These flips affect row 0 and row 1.
        for (int j = 0; j < C; j++) {
            if (current_flips[0][j]) {
                temp_sim_grid[0][j] ^= 1;
                if (j > 0) temp_sim_grid[0][j-1] ^= 1;
                if (j < C-1) temp_sim_grid[0][j+1] ^= 1;
                if (R > 1) temp_sim_grid[1][j] ^= 1; // Affects the next row to be processed
            }
        }

        // Propagate flips from row 1 to R-1.
        // `flips[i][j]` is determined by the state of `temp_sim_grid[i-1][j]`.
        // If `temp_sim_grid[i-1][j]` is 1, we must flip `(i,j)` to make `(i-1,j)` zero.
        for (int i = 1; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (temp_sim_grid[i-1][j] == 1) {
                    current_flips[i][j] = 1;
                    current_total_flips++;

                    // Apply this flip to `temp_sim_grid` and its neighbors.
                    temp_sim_grid[i][j] ^= 1;
                    if (j > 0) temp_sim_grid[i][j-1] ^= 1;
                    if (j < C-1) temp_sim_grid[i][j+1] ^= 1;
                    temp_sim_grid[i-1][j] ^= 1; // This makes (i-1,j) zero
                    if (i < R - 1) temp_sim_grid[i+1][j] ^= 1; // Affects the next row
                }
            }
        }

        // After all flips are determined based on the "make zero" propagation,
        // calculate the *actual* final grid state using the initial grid and all `current_flips`.
        int final_grid[R][C];
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                final_grid[i][j] = get_final_cell_value(R, C, initial_grid, current_flips, i, j);
            }
        }

        // Check if the `final_grid` is palindromic.
        int is_palindromic = 1;
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (final_grid[i][j] != final_grid[R - 1 - i][C - 1 - j]) {
                    is_palindromic = 0;
                    break;
                }
            }
            if (!is_palindromic) break;
        }

        if (is_palindromic) {
            if (current_total_flips < min_total_flips) {
                min_total_flips = current_total_flips;
            }
        }
    }

    return (min_total_flips == INT_MAX) ? -1 : min_total_flips;
}