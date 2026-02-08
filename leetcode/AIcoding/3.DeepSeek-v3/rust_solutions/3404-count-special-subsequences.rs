impl Solution {
    pub fn count_special_subsequences(nums: Vec<i32>) -> i32 {
        let mod_num = 1_000_000_007;
        let mut dp = [0; 3];
        for num in nums {
            match num {
                0 => {
                    dp[0] = (dp[0] * 2 + 1) % mod_num;
                }
                1 => {
                    dp[1] = (dp[1] * 2 % mod_num + dp[0]) % mod_num;
                }
                2 => {
                    dp[2] = (dp[2] * 2 % mod_num + dp[1]) % mod_num;
                }
                _ => {}
            }
        }
        dp[2]
    }
}