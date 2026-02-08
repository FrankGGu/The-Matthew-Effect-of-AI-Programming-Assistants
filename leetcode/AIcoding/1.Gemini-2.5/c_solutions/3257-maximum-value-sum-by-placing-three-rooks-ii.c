#include <limits.h> // Required for LLONG_MIN

long long maxValueSumByPlacingThreeRooksII(int** board, int boardSize, int* boardColSize) {
    int m = boardSize;
    if (m == 0) {
        return 0;
    }
    int n = boardColSize[0];

    // To place three non-attacking rooks, we need at least 3 rows and 3 columns.
    // If not, no valid placement is possible.
    if (m < 3 || n < 3) {
        return 0;
    }

    long long max_val = LLONG_MIN;
    int found_any_combination = 0;

    // Iterate through all combinations of 3 distinct rows (r1 < r2 < r3)
    for (int r1 = 0; r1 < m; ++r1) {
        for (int r2 = r1 + 1; r2 < m; ++r2) {
            for (int r3 = r2 + 1; r3 < m; ++r3) {
                // We have 3 distinct rows: r1, r2, r3

                // Iterate through all combinations of 3 distinct columns (c_idx1 < c_idx2 < c_idx3)
                for (int c_idx1 = 0; c_idx1 < n; ++c_idx1) {
                    for (int c_idx2 = c_idx1 + 1; c_idx2 < n; ++c_idx2) {
                        for (int c_idx3 = c_idx2 + 1; c_idx3 < n; ++c_idx3) {
                            // We have 3 distinct columns: c_idx1, c_idx2, c_idx3
                            // Now, we need to assign these three columns to the three chosen rows (r1, r2, r3)
                            // in all possible 3! = 6 permutations to find the maximum sum.

                            int cols[3] = {c_idx1, c_idx2, c_idx3};
                            long long current_sum;

                            // Permutation 1: (r1, cols[0]), (r2, cols[1]), (r3, cols[2])
                            current_sum = (long long)board[r1][cols[0]] + board[r2][cols[1]] + board[r3][cols[2]];
                            if (current_sum > max_val) {
                                max_val = current_sum;
                                found_any_combination = 1;
                            }

                            // Permutation 2: (r1, cols[0]), (r2, cols[2]), (r3, cols[1])
                            current_sum = (long long)board[r1][cols[0]] + board[r2][cols[2]] + board[r3][cols[1]];
                            if (current_sum > max_val) {
                                max_val = current_sum;
                                found_any_combination = 1;
                            }

                            // Permutation 3: (r1, cols[1]), (r2, cols[0]), (r3, cols[2])
                            current_sum = (long long)board[r1][cols[1]] + board[r2][cols[0]] + board[r3][cols[2]];
                            if (current_sum > max_val) {
                                max_val = current_sum;
                                found_any_combination = 1;
                            }

                            // Permutation 4: (r1, cols[1]), (r2, cols[2]), (r3, cols[0])
                            current_sum = (long long)board[r1][cols[1]] + board[r2][cols[2]] + board[r3][cols[0]];
                            if (current_sum > max_val) {
                                max_val = current_sum;
                                found_any_combination = 1;
                            }

                            // Permutation 5: (r1, cols[2]), (r2, cols[0]), (r3, cols[1])
                            current_sum = (long long)board[r1][cols[2]] + board[r2][cols[0]] + board[r3][cols[1]];
                            if (current_sum > max_val) {
                                max_val = current_sum;
                                found_any_combination = 1;
                            }

                            // Permutation 6: (r1, cols[2]), (r2, cols[1]), (r3, cols[0])
                            current_sum = (long long)board[r1][cols[2]] + board[r2][cols[1]] + board[r3][cols[0]];
                            if (current_sum > max_val) {
                                max_val = current_sum;
                                found_any_combination = 1;
                            }
                        }
                    }
                }
            }
        }
    }

    // If no valid combination was found (e.g., due to board dimensions being too small,
    // which should be handled by the initial check, but this acts as a safeguard),
    // return 0 as a default for no possible placement.
    // If the problem allows negative values and expects the maximum possible sum
    // even if it's negative, then LLONG_MIN would be the correct return in such cases.
    // For typical LeetCode problems, 0 is often returned for "no solution" or "empty result".
    if (!found_any_combination) {
        return 0;
    }

    return max_val;
}