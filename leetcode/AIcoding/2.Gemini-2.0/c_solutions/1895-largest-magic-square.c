#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestMagicSquare(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = *gridColSize;
    int max_k = 0;

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            for (int k = 1; i + k <= n && j + k <= m; ++k) {
                bool is_magic = true;
                int sum = 0;
                for (int l = 0; l < k; ++l) {
                    sum += grid[i][j + l];
                }

                for (int row = i; row < i + k; ++row) {
                    int row_sum = 0;
                    for (int col = j; col < j + k; ++col) {
                        row_sum += grid[row][col];
                    }
                    if (row_sum != sum) {
                        is_magic = false;
                        break;
                    }
                }

                if (!is_magic) continue;

                for (int col = j; col < j + k; ++col) {
                    int col_sum = 0;
                    for (int row = i; row < i + k; ++row) {
                        col_sum += grid[row][col];
                    }
                    if (col_sum != sum) {
                        is_magic = false;
                        break;
                    }
                }
                if (!is_magic) continue;

                int diag1_sum = 0;
                for (int l = 0; l < k; ++l) {
                    diag1_sum += grid[i + l][j + l];
                }
                if (diag1_sum != sum) {
                    is_magic = false;
                }

                if (!is_magic) continue;

                int diag2_sum = 0;
                for (int l = 0; l < k; ++l) {
                    diag2_sum += grid[i + l][j + k - 1 - l];
                }
                if (diag2_sum != sum) {
                    is_magic = false;
                }

                if (is_magic) {
                    max_k = (max_k > k) ? max_k : k;
                }
            }
        }
    }

    return max_k;
}