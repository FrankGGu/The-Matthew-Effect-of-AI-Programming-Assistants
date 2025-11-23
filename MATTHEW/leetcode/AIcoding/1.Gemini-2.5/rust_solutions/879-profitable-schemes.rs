impl Solution {
    pub fn profitable_schemes(n: i32, min_profit: i32, group: Vec<i32>, profit: Vec<i32>) -> i32 {
        let n_usize = n as usize;
        let min_profit_usize = min_profit as usize;
        let modulo = 1_000_000_007;

        let mut dp = vec![vec![0; n_usize + 1]; min_profit_usize + 1];

        dp[0][0] = 1;

        for i in 0..group.len() {
            let g_i = group[i] as usize;
            let p_i = profit[i] as usize;

            for g in (g_i..=n_usize).rev() {
                for p in (0..=min_profit_usize).rev() {
                    let current_profit = p;
                    let new_profit_idx = (current_profit + p_i).min(min_profit_usize);

                    dp[new_profit_idx][g] = (dp[new_profit_idx][g] + dp[current_profit][g - g_i]) % modulo;
                }
            }
        }

        let mut total_profitable_schemes = 0;
        for g in 0..=n_usize {
            total_profitable_schemes = (total_profitable_schemes + dp[min_profit_usize][g]) % modulo;
        }

        total_profitable_schemes
    }
}