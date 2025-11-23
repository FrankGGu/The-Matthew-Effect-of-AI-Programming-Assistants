impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let max_k = 2 * (n - 1); // Maximum number of steps for each person

        // dp[r1][r2] stores the maximum cherries collected when:
        // Person 1 is at (r1, k - r1)
        // Person 2 is at (r2, k - r2)
        // for the current total steps 'k' taken by both.
        // Initialize with i32::MIN to represent unreachable states.
        let mut dp: Vec<Vec<i32>> = vec![vec![i32::MIN; n]; n];

        // Base case: k=0, both at (0,0)
        if grid[0][0] == -1 {
            // Path blocked at start, no cherries can be picked.
            return 0;
        }
        dp[0][0] = grid[0][0];

        // Iterate through total steps k
        for k in 1..=max_k {
            let mut next_dp: Vec<Vec<i32>> = vec![vec![i32::MIN; n]; n];

            // Iterate through possible row positions for person 1 (r1)
            for r1 in 0..n {
                // Calculate column for person 1
                let c1 = k - r1;

                // Check if (r1, c1) is within grid bounds
                if c1 < 0 || c1 >= n {
                    continue;
                }
                // Check if (r1, c1) is a thorn
                if grid[r1][c1] == -1 {
                    continue;
                }

                // Iterate through possible row positions for person 2 (r2)
                for r2 in 0..n {
                    // Calculate column for person 2
                    let c2 = k - r2;

                    // Check if (r2, c2) is within grid bounds
                    if c2 < 0 || c2 >= n {
                        continue;
                    }
                    // Check if (r2, c2) is a thorn
                    if grid[r2][c2] == -1 {
                        continue;
                    }

                    // Calculate cherries collected at current (r1, c1) and (r2, c2)
                    let mut current_cherries = grid[r1][c1];
                    if r1 != r2 { // If they are at different cells, add person 2's cherry
                        current_cherries += grid[r2][c2];
                    }

                    let mut max_prev_cherries = i32::MIN;

                    // Consider 4 possible previous states (from k-1)
                    // Person 1 could have come from (r1-1, c1) (down) or (r1, c1-1) (right)
                    // Person 2 could have come from (r2-1, c2) (down) or (r2, c2-1) (right)

                    // 1. P1 from (r1-1, c1), P2 from (r2-1, c2)
                    // Previous state in dp table: dp[r1-1][r2-1]
                    // Valid if both r1 and r2 are greater than 0
                    if r1 > 0 && r2 > 0 {
                        max_prev_cherries = max_prev_cherries.max(dp[r1-1][r2-1]);
                    }

                    // 2. P1 from (r1-1, c1), P2 from (r2, c2-1)
                    // Previous state in dp table: dp[r1-1][r2]
                    // Valid if r1 > 0 and c2 > 0 (P2 moved right, so previous col was c2-1)
                    if r1 > 0 && c2 > 0 {
                        max_prev_cherries = max_prev_cherries.max(dp[r1-1][r2]);
                    }

                    // 3. P1 from (r1, c1-1), P2 from (r2-1, c2)
                    // Previous state in dp table: dp[r1][r2-1]
                    // Valid if c1 > 0 (P1 moved right, so previous col was c1-1) and r2 > 0
                    if c1 > 0 && r2 > 0 {
                        max_prev_cherries = max_prev_cherries.max(dp[r1][r2-1]);
                    }

                    // 4. P1 from (r1, c1-1), P2 from (r2, c2-1)
                    // Previous state in dp table: dp[r1][r2]
                    // Valid if c1 > 0 and c2 > 0
                    if c1 > 0 && c2 > 0 {
                        max_prev_cherries = max_prev_cherries.max(dp[r1][r2]);
                    }

                    // If any previous path was valid (not i32::MIN), update next_dp
                    if max_prev_cherries != i32::MIN {
                        next_dp[r1][r2] = max_prev_cherries + current_cherries;
                    }
                }
            }
            dp = next_dp; // Update dp for the next iteration
        }

        // The final answer is the maximum cherries at (n-1, n-1) for both people,
        // which corresponds to dp[n-1][n-1] after k = 2*(n-1) steps.
        // If no valid path exists, dp[n-1][n-1] will be i32::MIN, so return 0.
        dp[n-1][n-1].max(0)
    }
}