impl Solution {
    pub fn profitable_schemes(n: i32, min_profit: i32, group: Vec<i32>, profit: Vec<i32>) -> i32 {
        let n = n as usize;
        let min_profit = min_profit as usize;
        let k_mod = 1_000_000_007;
        let mut dp = vec![vec![0; min_profit + 1]; n + 1];
        dp[0][0] = 1;

        for k in 0..group.len() {
            let g = group[k] as usize;
            let p = profit[k] as usize;
            for i in (0..=n).rev() {
                for j in (0..=min_profit).rev() {
                    if i >= g {
                        let new_profit = (j + p).min(min_profit);
                        dp[i][new_profit] = (dp[i][new_profit] + dp[i - g][j]) % k_mod;
                    }
                }
            }
        }

        let mut res = 0;
        for i in 0..=n {
            res = (res + dp[i][min_profit]) % k_mod;
        }
        res
    }
}