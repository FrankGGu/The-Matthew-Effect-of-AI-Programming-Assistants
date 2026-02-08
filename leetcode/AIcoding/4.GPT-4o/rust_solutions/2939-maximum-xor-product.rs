impl Solution {
    pub fn maximum_xor_product(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; k as usize + 1];

        for &num in &nums {
            for j in (0..=k).rev() {
                if j >= num {
                    dp[j as usize] = dp[j as usize].max(dp[(j - num) as usize] ^ num);
                }
            }
        }

        dp[k as usize]
    }
}