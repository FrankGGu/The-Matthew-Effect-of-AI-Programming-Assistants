impl Solution {
    pub fn minimum_total_distance(robot: Vec<i32>, factories: Vec<Vec<i32>>) -> i64 {
        let n = robot.len();
        let m = factories.len();

        let mut robot = robot;
        robot.sort_unstable();

        let mut factories = factories;
        factories.sort_unstable_by_key(|f| f[0]);

        // dp[i][j] represents the minimum total distance to assign the first `i` robots
        // (i.e., robot[0]...robot[i-1]) to the first `j` factories (i.e., factories[0]...factories[j-1]).
        // `i` ranges from 0 to `n`, `j` ranges from 0 to `m`.
        let mut dp = vec![vec![i64::MAX; m + 1]; n + 1];

        // Base case: 0 robots assigned to 0 factories results in 0 distance.
        dp[0][0] = 0;

        // Iterate through the number of robots considered.
        for i in 0..=n {
            // Iterate through the number of factories considered.
            for j in 1..=m {
                // Option 1: The current factory (factories[j-1]) is not used for any of the first `i` robots.
                // In this case, the cost is the same as assigning `i` robots to the first `j-1` factories.
                // We use `min` to correctly propagate `i64::MAX` if the previous state was unreachable.
                dp[i][j] = dp[i][j].min(dp[i][j-1]);

                // Option 2: The current factory (factories[j-1]) is used.
                // It serves `k` robots, which must be the last `k` robots among the first `i` robots
                // (i.e., robot[i-k]...robot[i-1]).
                let current_factory_pos = factories[j-1][0];
                let current_factory_limit = factories[j-1][1];

                let mut current_cost_for_k_robots = 0;

                // `k` represents the number of robots assigned to factories[j-1].
                // `k` can range from 1 up to the minimum of `i` (total robots considered)
                // and `current_factory_limit` (capacity of the current factory).
                let max_k = i.min(current_factory_limit as usize);

                for k in 1..=max_k {
                    // Calculate the cost for assigning robot[i-k] to factories[j-1].
                    // We sum up the distances for these `k` robots.
                    current_cost_for_k_robots += (robot[i-k] - current_factory_pos).abs() as i64;

                    // If `k` robots are assigned to factories[j-1], the remaining `i-k` robots
                    // (robot[0]...robot[i-k-1]) must have been assigned to the first `j-1` factories.
                    // We check if `dp[i-k][j-1]` is reachable (not `i64::MAX`) to avoid overflow issues
                    // and ensure we only consider valid previous states.
                    if dp[i-k][j-1] != i64::MAX {
                        dp[i][j] = dp[i][j].min(dp[i-k][j-1] + current_cost_for_k_robots);
                    }
                }
            }
        }

        // The result is the minimum total distance to assign all `n` robots to all `m` factories.
        dp[n][m]
    }
}