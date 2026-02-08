impl Solution {
    pub fn minimum_operations(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        // column_costs[j][d] stores the number of operations if column j is set to digit d.
        // An operation counts if grid[i][j] != d.
        let mut column_costs: Vec<Vec<i32>> = vec![vec![0; 10]; n];

        for j in 0..n {
            for d in 0..10 {
                let mut current_cost = 0;
                for i in 0..m {
                    if grid[i][j] != d as i32 {
                        current_cost += 1;
                    }
                }
                column_costs[j][d] = current_cost;
            }
        }

        // dp[j][d] stores the minimum total operations for columns 0 to j,
        // with column j being set to digit d.
        let mut dp: Vec<Vec<i32>> = vec![vec![std::i32::MAX; 10]; n];

        // Base case: For the first column (j=0), the cost is just its own column_cost.
        for d in 0..10 {
            dp[0][d] = column_costs[0][d];
        }

        // Fill DP table for subsequent columns
        // For each column j from 1 to n-1:
        //   dp[j][d_j] = column_costs[j][d_j] + min(dp[j-1][d_prev]) where d_prev != d_j.
        // To optimize finding min(dp[j-1][d_prev]), we find the two smallest values
        // in dp[j-1] and their corresponding digits.
        for j in 1..n {
            let mut min1 = std::i32::MAX; // Smallest value in dp[j-1]
            let mut idx1 = -1;            // Digit corresponding to min1
            let mut min2 = std::i32::MAX; // Second smallest value in dp[j-1]

            // Find min1, idx1, and min2 from dp[j-1]
            for d_prev in 0..10 {
                if dp[j - 1][d_prev] < min1 {
                    min2 = min1; // Current min1 becomes min2
                    min1 = dp[j - 1][d_prev]; // New min1
                    idx1 = d_prev as i32;
                } else if dp[j - 1][d_prev] < min2 {
                    min2 = dp[j - 1][d_prev]; // New min2
                }
            }

            // Calculate dp[j][d_j] using the optimized min_prev_dp
            for d_j in 0..10 {
                if (d_j as i32) != idx1 {
                    // If d_j is not the digit corresponding to min1 from the previous column,
                    // we can use min1 from dp[j-1].
                    dp[j][d_j] = column_costs[j][d_j] + min1;
                } else {
                    // If d_j is the digit corresponding to min1 from the previous column,
                    // we must use min2 from dp[j-1] (because d_j != d_prev condition).
                    dp[j][d_j] = column_costs[j][d_j] + min2;
                }
            }
        }

        // The minimum total operations is the minimum value in the last row of the dp table.
        let mut min_total_ops = std::i32::MAX;
        for d in 0..10 {
            min_total_ops = min_total_ops.min(dp[n - 1][d]);
        }

        min_total_ops
    }
}