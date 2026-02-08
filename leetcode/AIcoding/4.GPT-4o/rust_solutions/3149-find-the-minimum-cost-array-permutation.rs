impl Solution {
    pub fn find_min_cost(n: i32, costs: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; 3]; n];

        for i in 0..n {
            for j in 0..3 {
                dp[i][j] = costs[i][j];
                if i > 0 {
                    for k in 0..3 {
                        if k != j {
                            dp[i][j] = dp[i][j].min(dp[i - 1][k] + costs[i][j]);
                        }
                    }
                }
            }
        }

        dp[n - 1].iter().cloned().min().unwrap()
    }
}