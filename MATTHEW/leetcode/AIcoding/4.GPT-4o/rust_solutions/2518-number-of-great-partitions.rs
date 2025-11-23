impl Solution {
    pub fn count_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let sum: i32 = nums.iter().sum();
        if sum < k {
            return 0;
        }
        let target = (sum - k) / 2;
        if (sum - k) % 2 != 0 {
            return 0;
        }
        let n = nums.len();
        let mut dp = vec![0; target as usize + 1];
        dp[0] = 1;

        for &num in &nums {
            for j in (num as usize..=target as usize).rev() {
                dp[j] = (dp[j] + dp[j - num as usize]) % mod_val;
            }
        }

        dp[target as usize] * 2 % mod_val
    }
}