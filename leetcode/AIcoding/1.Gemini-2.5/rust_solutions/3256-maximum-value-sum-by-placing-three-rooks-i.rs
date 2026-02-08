impl Solution {
    pub fn max_value_sum_by_placing_three_rooks_i(board: Vec<Vec<i32>>) -> i32 {
        let m = board.len();
        let n = board[0].len();

        // If the board dimensions are too small to place three rooks, return 0.
        // Three rooks require at least 3 distinct rows and 3 distinct columns.
        if m < 3 || n < 3 {
            return 0;
        }

        let mut max_total_sum = i32::MIN; // Initialize with the smallest possible i32 value

        // Iterate over all distinct triplets of rows (r1, r2, r3)
        for r1 in 0..m {
            for r2 in (r1 + 1)..m {
                for r3 in (r2 + 1)..m {
                    // For these three chosen rows (r1, r2, r3), we need to find
                    // three distinct columns (c1, c2, c3) to maximize
                    // board[r1][c1] + board[r2][c2] + board[r3][c3].

                    // Iterate over all possible columns for the first rook (c1 for r1)
                    for c1 in 0..n {
                        let mut current_sum_for_c1 = i32::MIN; // Max sum for r2, r3 given c1

                        // Find the top 2 values and their column indices for row r2,
                        // excluding column c1.
                        // rX_best1 stores (value, col_idx) of the largest element.
                        // rX_best2 stores (value, col_idx) of the second largest element.
                        let mut r2_best1 = (i32::MIN, -1);
                        let mut r2_best2 = (i32::MIN, -1);
                        for c in 0..n {
                            if c == c1 {
                                continue;
                            }
                            if board[r2][c] > r2_best1.0 {
                                r2_best2 = r2_best1;
                                r2_best1 = (board[r2][c], c as i32);
                            } else if board[r2][c] > r2_best2.0 {
                                r2_best2 = (board[r2][c], c as i32);
                            }
                        }

                        // Find the top 2 values and their column indices for row r3,
                        // excluding column c1.
                        let mut r3_best1 = (i32::MIN, -1);
                        let mut r3_best2 = (i32::MIN, -1);
                        for c in 0..n {
                            if c == c1 {
                                continue;
                            }
                            if board[r3][c] > r3_best1.0 {
                                r3_best2 = r3_best1;
                                r3_best1 = (board[r3][c], c as i32);
                            } else if board[r3][c] > r3_best2.0 {
                                r3_best2 = (board[r3][c], c as i32);
                            }
                        }

                        // Now combine the best options for r2 and r3.
                        // We need to ensure that we found at least two distinct columns for r2 and r3.
                        if r2_best1.0 != i32::MIN && r3_best1.0 != i32::MIN {
                            if r2_best1.1 != r3_best1.1 {
                                // Their best columns are different, so we can use them directly.
                                current_sum_for_c1 = current_sum_for_c1.max(r2_best1.0 + r3_best1.0);
                            } else {
                                // Their best columns are the same. We must use a second-best option for one of them.
                                // Option A: r2 uses its best, r3 uses its second best (if available).
                                if r3_best2.0 != i32::MIN {
                                    current_sum_for_c1 = current_sum_for_c1.max(r2_best1.0 + r3_best2.0);
                                }
                                // Option B: r2 uses its second best, r3 uses its best (if available).
                                if r2_best2.0 != i32::MIN {
                                    current_sum_for_c1 = current_sum_for_c1.max(r2_best2.0 + r3_best1.0);
                                }
                            }
                        }

                        // If a valid sum for r2 and r3 was found, add board[r1][c1] to it
                        // and update the overall maximum sum.
                        if current_sum_for_c1 != i32::MIN {
                            max_total_sum = max_total_sum.max(board[r1][c1] + current_sum_for_c1);
                        }
                    }
                }
            }
        }

        // If max_total_sum is still i32::MIN, it means no valid placement was found.
        // This case is handled by the initial check for m < 3 or n < 3,
        // so if we reach here and m, n >= 3, max_total_sum must have been updated.
        // If all values are negative, max_total_sum will be the sum of the three largest negative values.
        max_total_sum
    }
}