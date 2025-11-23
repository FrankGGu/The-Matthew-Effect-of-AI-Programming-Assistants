impl Solution {
    pub fn min_cost(costs: Vec<Vec<i32>>) -> i32 {
        if costs.is_empty() {
            return 0;
        }
        let mut dp = costs[0].clone();
        for i in 1..costs.len() {
            let mut new_dp = vec![0; 3];
            new_dp[0] = costs[i][0] + dp[1].min(dp[2]);
            new_dp[1] = costs[i][1] + dp[0].min(dp[2]);
            new_dp[2] = costs[i][2] + dp[0].min(dp[1]);
            dp = new_dp;
        }
        dp[0].min(dp[1].min(dp[2]))
    }
}