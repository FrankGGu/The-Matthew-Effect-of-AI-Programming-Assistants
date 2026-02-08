impl Solution {
    pub fn mct_from_leaf_values(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut dp = vec![vec![(0, 0); n]; n];

        for i in 0..n {
            dp[i][i].1 = arr[i];
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                dp[i][j].0 = i32::MAX;
                for k in i..j {
                    let cost = dp[i][k].0 + dp[k + 1][j].0 + dp[i][k].1 * dp[k + 1][j].1;
                    let max_val = dp[i][k].1.max(dp[k + 1][j].1);
                    if cost < dp[i][j].0 {
                        dp[i][j] = (cost, max_val);
                    }
                }
            }
        }

        dp[0][n - 1].0
    }
}