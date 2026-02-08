impl Solution {
    pub fn paint_walls(cost: Vec<i32>, time: Vec<i32>) -> i32 {
        let n = cost.len();
        let mut dp = vec![i32::MAX; n + 1];
        dp[n] = 0;

        for i in (0..n).rev() {
            let c = cost[i];
            let t = time[i] as usize;
            let mut new_dp = dp.clone();
            for j in 0..=n {
                if j > t {
                    new_dp[j] = new_dp[j].min(dp[j - t - 1] + c);
                } else {
                    new_dp[j] = new_dp[j].min(c);
                }
            }
            dp = new_dp;
        }

        dp[n]
    }
}