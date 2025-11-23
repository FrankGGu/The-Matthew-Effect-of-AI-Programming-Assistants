impl Solution {
    pub fn count_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let total_sum: i32 = nums.iter().sum();
        if (total_sum - k) % 2 != 0 || total_sum < k {
            return 0;
        }
        let target = (total_sum - k) / 2;
        let mod_val = 1_000_000_007;
        let n = nums.len();

        let mut dp = vec![0; (target + 1) as usize];
        dp[0] = 1;

        for &num in &nums {
            for j in (num..=target).rev() {
                dp[j as usize] = (dp[j as usize] + dp[(j - num) as usize]) % mod_val;
            }
        }

        dp[target as usize] * 2 % mod_val
    }
}