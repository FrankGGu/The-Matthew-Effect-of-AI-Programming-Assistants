#include <stdlib.h>

int largestMagicSquare(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    // Precompute prefix sums for rows
    int** row_sums = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        row_sums[i] = (int*)calloc(n + 1, sizeof(int));
        for (int j = 0; j < n; ++j) {
            row_sums[i][j+1] = row_sums[i][j] + grid[i][j];
        }
    }

    // Precompute prefix sums for columns
    int** col_sums = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i < m + 1; ++i) {
        col_sums[i] = (int*)calloc(n, sizeof(int));
    }
    for (int j = 0; j < n; ++j) {
        for (int i = 0; i < m; ++i) {
            col_sums[i+1][j] = col_sums[i][j] + grid[i][j];
        }
    }

    // Precompute prefix sums for main diagonals (\)
    int** diag1_sums = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        diag1_sums[i] = (int*)calloc(n, sizeof(int));
        for (int j = 0; j < n; ++j) {
            diag1_sums[i][j] = grid[i][j];
            if (i > 0 && j > 0) {
                diag1_sums[i][j] += diag1_sums[i-1][j-1];
            }
        }
    }

    // Precompute prefix sums for anti-diagonals (/)
    int** diag2_sums = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        diag2_sums[i] = (int*)calloc(n, sizeof(int));
        for (int j = 0; j < n; ++j) {
            diag2_sums[i][j] = grid[i][j];
            if (i > 0 && j < n - 1) {
                diag2_sums[i][j] += diag2_sums[i-1][j+1];
            }
        }
    }

    int max_k = (m < n) ? m : n;

    // Iterate k from largest possible size down to 1
    for (int k = max_k; k >= 1; --k) {
        // Iterate over all possible top-left corners (r, c)
        for (int r = 0; r <= m - k; ++r) {
            for (int c = 0; c <= n - k; ++c) {
                long long target_sum = -1; // Sentinel value to indicate sum not set yet

                // Check rows
                for (int i = r; i < r + k; ++i) {
                    int current_sum = row_sums[i][c + k] - row_sums[i][c];
                    if (target_sum == -1) {
                        target_sum = current_sum;
                    } else if (current_sum != target_sum) {
                        goto next_square; // Not a magic square, try next subgrid
                    }
                }

                // Check columns
                for (int j = c; j < c + k; ++j) {
                    int current_sum = col_sums[r + k][j] - col_sums[r][j];
                    if (current_sum != target_sum) {
                        goto next_square; // Not a magic square
                    }
                }

                // Check main diagonal
                int diag1_sum = diag1_sums[r + k - 1][c + k - 1];
                if (r > 0 && c > 0) {
                    diag1_sum -= diag1_sums[r-1][c-1];
                }
                if (diag1_sum != target_sum) {
                    goto next_square; // Not a magic square
                }

                // Check anti-diagonal
                int diag2_sum = diag2_sums[r + k - 1][c];
                if (r > 0 && c + k < n) {
                    diag2_sum -= diag2_sums[r-1][c+k];
                }
                if (diag2_sum != target_sum) {
                    goto next_square; // Not a magic square
                }

                // If all checks pass, we found the largest magic square
                // Free allocated memory before returning
                for (int i = 0; i < m; ++i) {
                    free(row_sums[i]);
                    free(diag1_sums[i]);
                    free(diag2_sums[i]);
                }
                free(row_sums);
                free(diag1_sums);
                free(diag2_sums);

                for (int i = 0; i < m + 1; ++i) {
                    free(col_sums[i]);
                }
                free(col_sums);

                return k;

                next_square:; // Label for goto statement
            }
        }
    }

    // A 1x1 square is always a magic square, so this line should theoretically not be reached.
    // However, as a fallback, return 1.
    return 1; 
}