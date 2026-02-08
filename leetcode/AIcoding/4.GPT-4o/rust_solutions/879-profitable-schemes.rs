impl Solution {
    pub fn profitable_schemes(n: i32, min_profit: i32, group: Vec<i32>, profit: Vec<i32>) -> i32 {
        let mod_val = 1_000_000_007;
        let m = group.len();
        let mut dp = vec![vec![0; (min_profit + 1) as usize]; (n + 1) as usize];
        dp[0][0] = 1;

        for i in 0..m {
            let g = group[i] as usize;
            let p = profit[i];
            for j in (g..=n as usize).rev() {
                for k in (0..=min_profit).rev() {
                    dp[j][k as usize] = (dp[j][k as usize] + dp[j - g][(k - p.max(0)) as usize]) % mod_val;
                }
            }
        }

        let mut result = 0;
        for j in 0..=n as usize {
            for k in min_profit..=min_profit {
                result = (result + dp[j][k as usize]) % mod_val;
            }
        }

        result
    }
}