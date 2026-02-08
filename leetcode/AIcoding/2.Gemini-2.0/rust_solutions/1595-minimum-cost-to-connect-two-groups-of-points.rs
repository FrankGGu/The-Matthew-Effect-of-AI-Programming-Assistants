impl Solution {
    pub fn connect_two_groups(cost: Vec<Vec<i32>>) -> i32 {
        let m = cost.len();
        let n = cost[0].len();
        let mut dp = vec![i32::MAX; 1 << n];
        dp[0] = 0;

        for i in 0..m {
            let mut new_dp = vec![i32::MAX; 1 << n];
            for mask in 0..(1 << n) {
                if dp[mask] == i32::MAX {
                    continue;
                }
                for j in 0..n {
                    new_dp[mask | (1 << j)] = new_dp[mask | (1 << j)].min(dp[mask] + cost[i][j]);
                }
                new_dp[mask] = new_dp[mask].min(dp[mask] + *cost[i].iter().min().unwrap());
            }
            dp = new_dp;
        }

        dp[(1 << n) - 1]
    }
}