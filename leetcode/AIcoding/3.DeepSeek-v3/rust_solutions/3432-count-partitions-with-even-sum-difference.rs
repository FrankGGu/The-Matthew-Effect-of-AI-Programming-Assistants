impl Solution {
    pub fn count_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let total_sum: i64 = nums.iter().map(|&x| x as i64).sum();
        if total_sum < 2 * k as i64 {
            return 0;
        }
        let mod_val = 1_000_000_007;
        let mut dp = vec![0; k as usize];
        dp[0] = 1;
        for &num in &nums {
            for j in (num as usize..k as usize).rev() {
                dp[j] = (dp[j] + dp[j - num as usize]) % mod_val;
            }
        }
        let mut total = 1;
        for _ in 0..nums.len() {
            total = (total * 2) % mod_val;
        }
        let mut invalid = 0;
        for j in 0..k as usize {
            invalid = (invalid + dp[j]) % mod_val;
        }
        invalid = (invalid * 2) % mod_val;
        (total - invalid + mod_val) % mod_val
    }
}