impl Solution {
    pub fn min_cost(n: i32, cuts: Vec<i32>) -> i32 {
        let mut cuts_mut = cuts;
        cuts_mut.push(0);
        cuts_mut.push(n);
        cuts_mut.sort();

        let m = cuts_mut.len();
        let mut dp = vec![vec![0; m]; m];

        for len in 2..m {
            for i in 0..(m - len) {
                let j = i + len;
                dp[i][j] = i32::MAX;
                for k in (i + 1)..j {
                    dp[i][j] = dp[i][j].min(dp[i][k] + dp[k][j] + cuts_mut[j] - cuts_mut[i]);
                }
            }
        }

        dp[0][m - 1]
    }
}