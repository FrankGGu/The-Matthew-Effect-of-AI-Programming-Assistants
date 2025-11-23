impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        // dp[r][c1][c2] stores the maximum cherries collected when
        // both robots are at row `r`, robot1 at col `c1`, robot2 at col `c2`.
        // Initialize with i32::MIN to represent unreachable states.
        let mut dp = vec![vec![vec![i32::MIN; cols]; cols]; rows];

        // Base case: first row (r = 0)
        // Robot1 starts at (0, 0), Robot2 starts at (0, cols - 1)
        dp[0][0][cols - 1] = grid[0][0] + (if 0 != cols - 1 { grid[0][cols - 1] } else { 0 });

        // Fill the DP table for subsequent rows
        for r in 1..rows {
            for c1 in 0..cols {
                for c2 in 0..cols {
                    // Cherries collected at the current cell(s)
                    let current_cherries = grid[r][c1] + (if c1 != c2 { grid[r][c2] } else { 0 });

                    // Find the maximum cherries from previous row's possible positions
                    let mut max_prev_val = i32::MIN;

                    // Robot1's previous column (c1-1, c1, c1+1)
                    for prev_c1_offset in -1..=1 {
                        let prev_c1 = c1 as i32 + prev_c1_offset;
                        if prev_c1 >= 0 && prev_c1 < cols as i32 {
                            // Robot2's previous column (c2-1, c2, c2+1)
                            for prev_c2_offset in -1..=1 {
                                let prev_c2 = c2 as i32 + prev_c2_offset;
                                if prev_c2 >= 0 && prev_c2 < cols as i32 {
                                    let val = dp[r - 1][prev_c1 as usize][prev_c2 as usize];
                                    if val != i32::MIN {
                                        max_prev_val = max_prev_val.max(val);
                                    }
                                }
                            }
                        }
                    }

                    // If there was a reachable state in the previous row, update current DP state
                    if max_prev_val != i32::MIN {
                        dp[r][c1][c2] = current_cherries + max_prev_val;
                    }
                }
            }
        }

        // The maximum cherries will be the maximum value in the last row
        let mut max_cherries = 0; // Cherries are non-negative, so 0 is a safe initial value
        for c1 in 0..cols {
            for c2 in 0..cols {
                max_cherries = max_cherries.max(dp[rows - 1][c1][c2]);
            }
        }

        max_cherries
    }
}