impl Solution {
    pub fn min_cost(costs: Vec<i32>, x: i32) -> i64 {
        let n = costs.len();
        let mut dp = vec![vec![0i64; n]; n];

        for i in 0..n {
            for j in 0..n {
                dp[0][j] = costs[j] as i64;
            }
        }

        for i in 1..n {
            for j in 0..n {
                let mut min_val = i64::MAX;
                for k in 0..n {
                    let new_idx = (k + i) % n;
                    min_val = min_val.min(costs[new_idx] as i64);
                }
                dp[i][j] = dp[i - 1][j].min(dp[i - 1][(j + n - 1) % n] + x as i64);
                dp[i][j] = dp[i][j].min(min_val + (i as i64) * (x as i64));
            }
        }

        let mut ans = i64::MAX;
        for i in 0..n {
            ans = ans.min(dp[n - 1][i]);
        }

        ans
    }
}