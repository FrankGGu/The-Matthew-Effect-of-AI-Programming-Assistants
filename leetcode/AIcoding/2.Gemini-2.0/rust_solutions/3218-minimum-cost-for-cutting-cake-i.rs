impl Solution {
    pub fn min_cost(n: i32, cuts: Vec<i32>) -> i32 {
        let mut cuts = cuts;
        cuts.sort();
        let mut cuts = cuts;
        cuts.insert(0, 0);
        cuts.push(n);
        let m = cuts.len();
        let mut dp = vec![vec![0; m]; m];

        for len in 2..m {
            for i in 0..(m - len) {
                let j = i + len;
                dp[i][j] = i32::MAX;
                for k in (i + 1)..j {
                    dp[i][j] = dp[i][j].min(dp[i][k] + dp[k][j] + cuts[j] - cuts[i]);
                }
            }
        }

        dp[0][m - 1]
    }
}