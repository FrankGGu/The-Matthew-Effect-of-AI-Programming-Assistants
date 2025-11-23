impl Solution {
    pub fn count_possible_sets(n: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let mut dp = vec![0; n as usize + 1];
        dp[0] = 1;

        for i in 1..=n {
            for j in (i..=n).rev() {
                dp[j as usize] = (dp[j as usize] + dp[(j - i) as usize]) % mod_val;
            }
        }

        let mut result = 0;
        for count in dp {
            result = (result + count) % mod_val;
        }

        result
    }
}