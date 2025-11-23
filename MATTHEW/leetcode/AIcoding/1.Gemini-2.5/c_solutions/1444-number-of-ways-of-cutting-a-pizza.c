#include <string.h>
#include <stdlib.h>

static int get_apples_in_rect(int r1, int c1, int r2, int c2, int m, int n, int** suffix_apples) {
    return suffix_apples[r1][c1] - suffix_apples[r2 + 1][c1] - suffix_apples[r1][c2 + 1] + suffix_apples[r2 + 1][c2 + 1];
}

int ways(char** pizza, int pizzaSize, int* pizzaColSize, int k) {
    int m = pizzaSize;
    int n = *pizzaColSize; // All rows have the same number of columns

    long long MOD = 1e9 + 7;

    // suffix_apples[r][c] stores the number of apples in the sub-pizza from [r...m-1][c...n-1]
    // Size (m+1) x (n+1) to handle boundary conditions (m and n indices)
    int** suffix_apples = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; ++i) {
        suffix_apples[i] = (int*)calloc((n + 1), sizeof(int)); // calloc initializes to 0
    }

    // Populate suffix_apples array
    for (int r = m - 1; r >= 0; --r) {
        for (int c = n - 1; c >= 0; --c) {
            suffix_apples[r][c] = (pizza[r][c] == 'A' ? 1 : 0);
            suffix_apples[r][c] += suffix_apples[r + 1][c];
            suffix_apples[r][c] += suffix_apples[r][c + 1];
            suffix_apples[r][c] -= suffix_apples[r + 1][c + 1];
        }
    }

    // dp[k_prime][r][c] stores the number of ways to cut the sub-pizza [r...m-1][c...n-1]
    // into k_prime pieces.
    // k_prime ranges from 1 to k. r from 0 to m-1. c from 0 to n-1.
    int*** dp = (int***)malloc((k + 1) * sizeof(int**));
    for (int i = 0; i <= k; ++i) {
        dp[i] = (int**)malloc(m * sizeof(int*));
        for (int j = 0; j < m; ++j) {
            dp[i][j] = (int*)calloc(n, sizeof(int)); // calloc initializes to 0
        }
    }

    // Base case: k_prime = 1
    // If a sub-pizza has at least one apple, there's 1 way to cut it into 1 piece (no cuts needed).
    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            if (get_apples_in_rect(r, c, m - 1, n - 1, m, n, suffix_apples) > 0) {
                dp[1][r][c] = 1;
            }
        }
    }

    // Fill DP table for k_prime from 2 to k
    for (int k_prime = 2; k_prime <= k; ++k_prime) {
        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                // If the current sub-pizza has no apples, it cannot be cut into k_prime pieces.
                if (suffix_apples[r][c] == 0) {
                    continue;
                }

                // Try horizontal cuts
                // Cut at row next_r, meaning the first piece is [r...next_r][c...n-1]
                // and remaining k_prime-1 pieces are from [next_r+1...m-1][c...n-1]
                for (int next_r = r; next_r < m - 1; ++next_r) {
                    if (get_apples_in_rect(r, c, next_r, n - 1, m, n, suffix_apples) > 0) {
                        dp[k_prime][r][c] = (dp[k_prime][r][c] + dp[k_prime - 1][next_r + 1][c]) % MOD;
                    }
                }

                // Try vertical cuts
                // Cut at column next_c, meaning the first piece is [r...m-1][c...next_c]
                // and remaining k_prime-1 pieces are from [r...m-1][next_c+1...n-1]
                for (int next_c = c; next_c < n - 1; ++next_c) {
                    if (get_apples_in_rect(r, c, m - 1, next_c, m, n, suffix_apples) > 0) {
                        dp[k_prime][r][c] = (dp[k_prime][r][c] + dp[k_prime - 1][r][next_c + 1]) % MOD;
                    }
                }
            }
        }
    }

    int result = dp[k][0][0];

    // Free allocated memory
    for (int i = 0; i <= m; ++i) {
        free(suffix_apples[i]);
    }
    free(suffix_apples);

    for (int i = 0; i <= k; ++i) {
        for (int j = 0; j < m; ++j) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}