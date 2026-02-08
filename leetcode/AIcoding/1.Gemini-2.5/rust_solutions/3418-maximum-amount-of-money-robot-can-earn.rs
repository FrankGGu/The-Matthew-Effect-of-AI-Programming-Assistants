use std::cmp::max;

impl Solution {
    pub fn max_money_robot_can_earn(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        // dp[k][r1][r2] stores the maximum money collected when both robots have taken k steps.
        // Robot 1 is at (r1, c1) where c1 = k - r1
        // Robot 2 is at (r2, c2) where c2 = k - r2
        // k ranges from 0 to m + n - 2 (total steps to reach (m-1, n-1))
        // r1, r2 range from 0 to m - 1
        let mut dp = vec![vec![vec![i32::MIN; m]; m]; m + n - 1];

        // Base case: Both robots start at (0, 0)
        // k = 0, r1 = 0, r2 = 0
        dp[0][0][0] = grid[0][0];

        // Iterate through the number of steps k
        // k goes from 1 to m + n - 2
        for k in 1..(m + n - 1) {
            // Iterate through possible row positions for robot 1
            for r1 in 0..m {
                // Calculate column for robot 1
                let c1 = k - r1;
                // Check if c1 is a valid column
                if c1 < 0 || c1 >= n {
                    continue;
                }

                // Iterate through possible row positions for robot 2
                for r2 in 0..m {
                    // Calculate column for robot 2
                    let c2 = k - r2;
                    // Check if c2 is a valid column
                    if c2 < 0 || c2 >= n {
                        continue;
                    }

                    // Problem constraint: "The robots cannot occupy the same cell at the same time,
                    // except for the starting cell (0, 0) and the ending cell (m - 1, n - 1)."
                    // If they are at the same intermediate cell, this state is invalid.
                    if r1 == r2 && c1 == c2 {
                        // If it's an intermediate step (not start and not end), this path is invalid.
                        // We skip updating dp[k][r1][r2], leaving it as i32::MIN.
                        if k > 0 && k < m + n - 2 {
                            continue;
                        }
                    }

                    let mut max_prev_money = i32::MIN;

                    // Robot 1 can come from (r1-1, c1) (Down) or (r1, c1-1) (Right)
                    // Robot 2 can come from (r2-1, c2) (Down) or (r2, c2-1) (Right)
                    // Combining these gives 4 possible previous states:

                    // 1. Robot 1 from (r1-1, c1), Robot 2 from (r2-1, c2) (Both Down)
                    if r1 > 0 && r2 > 0 {
                        max_prev_money = max(max_prev_money, dp[k - 1][r1 - 1][r2 - 1]);
                    }
                    // 2. Robot 1 from (r1-1, c1), Robot 2 from (r2, c2-1) (R1 Down, R2 Right)
                    // (r2, k-r2-1) means previous row for R2 was r2.
                    if r1 > 0 && c2 > 0 {
                        max_prev_money = max(max_prev_money, dp[k - 1][r1 - 1][r2]);
                    }
                    // 3. Robot 1 from (r1, c1-1), Robot 2 from (r2-1, c2) (R1 Right, R2 Down)
                    // (r1, k-r1-1) means previous row for R1 was r1.
                    if c1 > 0 && r2 > 0 {
                        max_prev_money = max(max_prev_money, dp[k - 1][r1][r2 - 1]);
                    }
                    // 4. Robot 1 from (r1, c1-1), Robot 2 from (r2, c2-1) (Both Right)
                    // (r1, k-r1-1) means previous row for R1 was r1.
                    // (r2, k-r2-1) means previous row for R2 was r2.
                    if c1 > 0 && c2 > 0 {
                        max_prev_money = max(max_prev_money, dp[k - 1][r1][r2]);
                    }

                    // If no previous path was reachable, this path is also unreachable.
                    if max_prev_money == i32::MIN {
                        continue;
                    }

                    let mut current_money = grid[r1][c1];
                    // If robots are at different cells, add money from robot 2's cell.
                    // If they are at the same cell, money is collected only once.
                    // (The "cannot occupy same cell" rule for intermediate steps is handled above by `continue`).
                    if r1 != r2 || c1 != c2 {
                        current_money += grid[r2][c2];
                    }

                    dp[k][r1][r2] = max_prev_money + current_money;
                }
            }
        }

        // The final answer is the maximum money collected when both robots reach (m-1, n-1).
        // This corresponds to k = m + n - 2, r1 = m - 1, r2 = m - 1.
        // Since grid values are non-negative, any valid path will yield non-negative money.
        // If dp[m + n - 2][m - 1][m - 1] is i32::MIN, it means no valid path exists under the rules.
        // However, with non-negative grid values and no "thorns", a path always exists.
        dp[m + n - 2][m - 1][m - 1]
    }
}