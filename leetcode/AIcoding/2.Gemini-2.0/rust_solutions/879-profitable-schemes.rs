impl Solution {
    pub fn profitable_schemes(n: i32, min_profit: i32, group: Vec<i32>, profit: Vec<i32>) -> i32 {
        let kMod: i32 = 1_000_000_007;
        let n = n as usize;
        let min_profit = min_profit as usize;
        let mut dp = vec![vec![0; min_profit + 1]; n + 1];
        dp[0][0] = 1;

        for i in 0..group.len() {
            let g = group[i] as usize;
            let p = profit[i] as usize;

            for j in (0..=n).rev() {
                for k in 0..=min_profit {
                    if j + g <= n {
                        dp[j + g][min(min_profit, k + p)] = (dp[j + g][min(min_profit, k + p)] + dp[j][k]) % kMod;
                    }
                }
            }
        }

        let mut total = 0;
        for i in 0..=n {
            total = (total + dp[i][min_profit]) % kMod;
        }

        total
    }
}