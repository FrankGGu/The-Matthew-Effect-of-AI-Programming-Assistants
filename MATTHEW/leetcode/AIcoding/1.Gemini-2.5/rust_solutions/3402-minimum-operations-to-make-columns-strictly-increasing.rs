impl Solution {
    pub fn minimum_operations(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        if m == 1 {
            return 0;
        }

        // is_valid_diff[r][d] is true if for all k in 0..n-1,
        // grid[r][k] < grid[r+1][(k - d + n) % n].
        // Here, 'r' is the index of the upper row (0 to m-2),
        // and 'd' represents the difference in shifts (s_curr - s_prev + n) % n.
        // If row 'r' is shifted by s_prev and row 'r+1' is shifted by s_curr,
        // then the element at column 'j' in row 'r' is grid[r][(j - s_prev + n) % n],
        // and in row 'r+1' is grid[r+1][(j - s_curr + n) % n].
        // For the condition grid[r][(j - s_prev + n) % n] < grid[r+1][(j - s_curr + n) % n] to hold for all j,
        // let k_original = (j - s_prev + n) % n. Then j = (k_original + s_prev) % n.
        // The condition becomes grid[r][k_original] < grid[r+1][((k_original + s_prev) - s_curr + n) % n],
        // which simplifies to grid[r][k_original] < grid[r+1][(k_original - d + n) % n] for all k_original.
        let mut is_valid_diff = vec![vec![false; n]; m - 1];

        for r in 0..m - 1 {
            for d in 0..n {
                let mut valid = true;
                for k in 0..n {
                    if grid[r][k] >= grid[r + 1][(k - d + n) % n] {
                        valid = false;
                        break;
                    }
                }
                is_valid_diff[r][d] = valid;
            }
        }

        // dp_prev[s_prev] stores the minimum operations for rows 0 to (i-1),
        // given that row (i-1) was shifted by s_prev.
        // dp_curr[s_curr] stores the minimum operations for rows 0 to i,
        // given that row i is shifted by s_curr.
        let mut dp_prev = vec![0; n];
        let mut dp_curr = vec![0; n];

        // Base case for row 0:
        // The cost for row 0 is 1 if it's shifted (s_0 > 0), else 0.
        for s_0 in 0..n {
            dp_prev[s_0] = if s_0 > 0 { 1 } else { 0 };
        }

        // Fill DP table for rows 1 to m-1
        for i in 1..m {
            for s_curr in 0..n {
                let mut min_prev_dp = std::i32::MAX;
                for s_prev in 0..n {
                    let d = (s_curr - s_prev + n) % n;
                    if is_valid_diff[i - 1][d] {
                        // If the transition from s_prev to s_curr is valid,
                        // and the previous state was reachable.
                        if dp_prev[s_prev] != std::i32::MAX {
                            min_prev_dp = min_prev_dp.min(dp_prev[s_prev]);
                        }
                    }
                }

                if min_prev_dp == std::i32::MAX {
                    // If no valid previous state leads to s_curr, this state is unreachable.
                    dp_curr[s_curr] = std::i32::MAX;
                } else {
                    // Cost is min_prev_dp plus 1 if current row is shifted.
                    dp_curr[s_curr] = min_prev_dp + (if s_curr > 0 { 1 } else { 0 });
                }
            }
            // Update dp_prev for the next iteration.
            dp_prev.copy_from_slice(&dp_curr);
        }

        // The final answer is the minimum value in dp_prev (which now holds dp[m-1]).
        let mut min_ops = std::i32::MAX;
        for s_last in 0..n {
            min_ops = min_ops.min(dp_prev[s_last]);
        }

        if min_ops == std::i32::MAX {
            -1 // Impossible to make all columns strictly increasing
        } else {
            min_ops
        }
    }
}