impl Solution {
    pub fn count_special_subsequences(nums: Vec<i32>) -> i32 {
        let mod_val = 1_000_000_007;
        let mut dp = [0; 3];

        for &num in &nums {
            if num == 0 {
                dp[0] = (2 * dp[0] + 1) % mod_val;
            } else if num == 1 {
                dp[1] = (2 * dp[1] + dp[0]) % mod_val;
            } else {
                dp[2] = (2 * dp[2] + dp[1]) % mod_val;
            }
        }

        dp[2]
    }
}