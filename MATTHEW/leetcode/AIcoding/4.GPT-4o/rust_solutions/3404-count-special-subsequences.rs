impl Solution {
    pub fn count_special_subsequences(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        let mut last = vec![-1; 4];
        dp[0] = 1;

        for i in 0..n {
            for j in 0..4 {
                dp[i + 1] = (dp[i + 1] + dp[i]) % MOD;
            }
            if nums[i] < 4 {
                dp[i + 1] = (dp[i + 1] + dp[last[nums[i] as usize] as usize]) % MOD;
                last[nums[i] as usize] = i as i32;
            }
        }
        (dp[n] - 1 + MOD) % MOD
    }
}