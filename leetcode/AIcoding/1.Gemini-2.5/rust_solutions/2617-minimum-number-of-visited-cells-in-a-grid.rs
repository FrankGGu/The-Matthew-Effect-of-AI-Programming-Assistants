use std::collections::VecDeque;

const INF: i32 = i32::MAX;

impl Solution {
    pub fn minimum_visited_cells(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dp = vec![vec![INF; n]; m];
        dp[0][0] = 1;

        // Deques for each row and column.
        // row_deques[r] stores (dp_val, col_idx) for cells (r, col_idx) that can potentially reach future cells in row r.
        // col_deques[c] stores (dp_val, row_idx) for cells (row_idx, c) that can potentially reach future cells in column c.
        let mut row_deques: Vec<VecDeque<(i32, usize)>> = vec![VecDeque::new(); m];
        let mut col_deques: Vec<VecDeque<(i32, usize)>> = vec![VecDeque::new(); n];

        // Initialize deques for the starting cell (0,0)
        row_deques[0].push_back((1, 0));
        col_deques[0].push_back((1, 0));

        for r in 0..m {
            for c in 0..n {
                // If (r,c) is (0,0), its dp value is already set and deques initialized.
                if r == 0 && c == 0 {
                    continue;
                }

                // Calculate dp[r][c] from previous cells in the same column.
                // We need min(dp[prev_r][c]) for prev_r < r such that prev_r + grid[prev_r][c] >= r.
                // Remove elements from the front of col_deques[c] that are too far back to reach current cell (r,c).
                while let Some(&(val, prev_r)) = col_deques[c].front() {
                    if prev_r + grid[prev_r][c] as usize >= r {
                        break;
                    }
                    col_deques[c].pop_front();
                }
                // If there's a valid cell in the deque, update dp[r][c].
                if let Some(&(val, _)) = col_deques[c].front() {
                    if val != INF { // Ensure the source cell was reachable
                        dp[r][c] = dp[r][c].min(val + 1);
                    }
                }

                // Calculate dp[r][c] from previous cells in the same row.
                // We need min(dp[r][prev_c]) for prev_c < c such that prev_c + grid[r][prev_c] >= c.
                // Remove elements from the front of row_deques[r] that are too far back to reach current cell (r,c).
                while let Some(&(val, prev_c)) = row_deques[r].front() {
                    if prev_c + grid[r][prev_c] as usize >= c {
                        break;
                    }
                    row_deques[r].pop_front();
                }
                // If there's a valid cell in the deque, update dp[r][c].
                if let Some(&(val, _)) = row_deques[r].front() {
                    if val != INF { // Ensure the source cell was reachable
                        dp[r][c] = dp[r][c].min(val + 1);
                    }
                }

                // If the current cell (r,c) is reachable, add it to the deques.
                if dp[r][c] != INF {
                    // Add (dp[r][c], c) to row_deques[r], maintaining monotonic property (increasing dp_val).
                    while let Some(&(val, _)) = row_deques[r].back() {
                        if val >= dp[r][c] {
                            row_deques[r].pop_back();
                        } else {
                            break;
                        }
                    }
                    row_deques[r].push_back((dp[r][c], c));

                    // Add (dp[r][c], r) to col_deques[c], maintaining monotonic property (increasing dp_val).
                    while let Some(&(val, _)) = col_deques[c].back() {
                        if val >= dp[r][c] {
                            col_deques[c].pop_back();
                        } else {
                            break;
                        }
                    }
                    col_deques[c].push_back((dp[r][c], r));
                }
            }
        }

        // The result is dp[m-1][n-1]. If it's still INF, the target is unreachable.
        if dp[m - 1][n - 1] == INF {
            -1
        } else {
            dp[m - 1][n - 1]
        }
    }
}