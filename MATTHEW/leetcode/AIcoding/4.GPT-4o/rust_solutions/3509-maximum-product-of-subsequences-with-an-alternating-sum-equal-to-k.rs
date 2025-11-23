impl Solution {
    pub fn max_product(nums: Vec<i32>, k: i32) -> i32 {
        let mut dp = vec![0; (k + 1) as usize];
        dp[0] = 1;

        for &num in &nums {
            for j in (num..=k).rev() {
                dp[j as usize] = dp[j as usize].max(dp[(j - num) as usize] * num);
            }
        }

        dp[k as usize]
    }
}