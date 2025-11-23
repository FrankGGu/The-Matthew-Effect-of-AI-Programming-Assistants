impl Solution {
    pub fn num_ways(steps: i32, arr_len: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let max_pos = (arr_len - 1).min(steps);
        let mut dp = vec![0; (max_pos + 1) as usize + 1];
        dp[0] = 1;

        for _ in 0..steps {
            let mut new_dp = vec![0; (max_pos + 1) as usize + 1];
            for j in 0..=max_pos {
                new_dp[j as usize] = (new_dp[j as usize] + dp[j as usize]) % mod_val;
                if j > 0 {
                    new_dp[j as usize] = (new_dp[j as usize] + dp[(j - 1) as usize]) % mod_val;
                }
                if j < max_pos {
                    new_dp[j as usize] = (new_dp[j as usize] + dp[(j + 1) as usize]) % mod_val;
                }
            }
            dp = new_dp;
        }

        dp[0]
    }
}