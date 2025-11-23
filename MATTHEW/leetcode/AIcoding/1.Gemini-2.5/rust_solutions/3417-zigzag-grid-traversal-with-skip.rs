struct Solution;

impl Solution {
    pub fn zigzag_traverse_with_skip(grid: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let m_rows = grid.len();
        if m_rows == 0 {
            return Vec::new();
        }
        let n_cols = grid[0].len();
        if n_cols == 0 {
            return Vec::new();
        }

        let mut result = Vec::new();
        let mut skip_active = false;
        let mut current_count = 0; // Counts visited cells or skipped cells

        // Iterate through diagonals
        // The sum of row and column indices (r + c) is constant for each diagonal.
        // Diagonals range from sum_rc = 0 to sum_rc = m_rows + n_cols - 2.
        for sum_rc in 0..(m_rows + n_cols - 1) {
            if sum_rc % 2 == 0 { // Even sum: traverse up-right (e.g., (2,0) -> (1,1) -> (0,2))
                // Starting point for up-right traversal:
                // max row index is m_rows - 1, max col index is n_cols - 1.
                // r starts as high as possible, c as low as possible for this sum.
                // r = min(sum_rc, m_rows - 1), c = sum_rc - r
                let mut r_curr = (sum_rc as usize).min(m_rows - 1);
                let mut c_curr = sum_rc - r_curr;

                while c_curr < n_cols { // r_curr >= 0 is always true for usize
                    // Apply skip logic
                    if k == 0 {
                        result.push(grid[r_curr][c_curr]);
                    } else {
                        if skip_active {
                            current_count += 1;
                            if current_count == k {
                                skip_active = false;
                                current_count = 0;
                            }
                        } else {
                            result.push(grid[r_curr][c_curr]);
                            current_count += 1;
                            if current_count == k {
                                skip_active = true;
                                current_count = 0;
                            }
                        }
                    }

                    if r_curr == 0 {
                        break; // Reached top edge, cannot go further up
                    }
                    r_curr -= 1;
                    c_curr += 1;
                }
            } else { // Odd sum: traverse down-left (e.g., (0,1) -> (1,0))
                // Starting point for down-left traversal:
                // c starts as high as possible, r as low as possible for this sum.
                // c = min(sum_rc, n_cols - 1), r = sum_rc - c
                let mut c_curr = (sum_rc as usize).min(n_cols - 1);
                let mut r_curr = sum_rc - c_curr;

                while r_curr < m_rows { // c_curr >= 0 is always true for usize
                    // Apply skip logic
                    if k == 0 {
                        result.push(grid[r_curr][c_curr]);
                    } else {
                        if skip_active {
                            current_count += 1;
                            if current_count == k {
                                skip_active = false;
                                current_count = 0;
                            }
                        } else {
                            result.push(grid[r_curr][c_curr]);
                            current_count += 1;
                            if current_count == k {
                                skip_active = true;
                                current_count = 0;
                            }
                        }
                    }

                    if c_curr == 0 {
                        break; // Reached left edge, cannot go further left
                    }
                    r_curr += 1;
                    c_curr -= 1;
                }
            }
        }

        result
    }
}