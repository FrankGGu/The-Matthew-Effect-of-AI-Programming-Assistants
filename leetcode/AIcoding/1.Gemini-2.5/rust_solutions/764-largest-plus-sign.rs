use std::cmp;

impl Solution {
    pub fn order_of_largest_plus_sign(n: i32, mines: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;

        // grid[r][c] = 0 if it's a mine, 1 otherwise
        let mut grid = vec![vec![1; n_usize]; n_usize];
        for mine in mines {
            let r = mine[0] as usize;
            let c = mine[1] as usize;
            grid[r][c] = 0;
        }

        // dp[r][c] will store the minimum of the lengths of the four arms
        // (left, right, up, down) ending/starting at (r,c).
        // Initialize dp with 0s. If a cell is not a mine, its dp value is
        // initially set to `n`, representing the maximum possible arm length.
        // If a cell is a mine, it remains 0.
        let mut dp = vec![vec![0; n_usize]; n_usize];
        for r in 0..n_usize {
            for c in 0..n_usize {
                if grid[r][c] == 1 {
                    dp[r][c] = n;
                }
            }
        }

        // Calculate left and right arm lengths and update dp
        for r in 0..n_usize {
            let mut count = 0;
            // Left pass: calculate consecutive non-mine cells to the left
            for c in 0..n_usize {
                if grid[r][c] == 1 {
                    count += 1;
                } else {
                    count = 0;
                }
                dp[r][c] = cmp::min(dp[r][c], count);
            }

            count = 0;
            // Right pass: calculate consecutive non-mine cells to the right
            for c in (0..n_usize).rev() {
                if grid[r][c] == 1 {
                    count += 1;
                } else {
                    count = 0;
                }
                dp[r][c] = cmp::min(dp[r][c], count);
            }
        }

        // Calculate up and down arm lengths and update dp
        for c in 0..n_usize {
            let mut count = 0;
            // Up pass: calculate consecutive non-mine cells upwards
            for r in 0..n_usize {
                if grid[r][c] == 1 {
                    count += 1;
                } else {
                    count = 0;
                }
                dp[r][c] = cmp::min(dp[r][c], count);
            }

            count = 0;
            // Down pass: calculate consecutive non-mine cells downwards
            for r in (0..n_usize).rev() {
                if grid[r][c] == 1 {
                    count += 1;
                } else {
                    count = 0;
                }
                dp[r][c] = cmp::min(dp[r][c], count);
            }
        }

        // The maximum value in dp is the order of the largest plus sign
        let mut max_order = 0;
        for r in 0..n_usize {
            for c in 0..n_usize {
                max_order = cmp::max(max_order, dp[r][c]);
            }
        }

        max_order
    }
}