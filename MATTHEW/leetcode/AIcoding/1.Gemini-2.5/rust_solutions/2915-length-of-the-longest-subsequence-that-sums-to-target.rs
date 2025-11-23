impl Solution {
    pub fn longest_subsequence(nums: Vec<i32>, target: i32) -> i32 {
        let mut dp = vec![-1; (target + 1) as usize];
        dp[0] = 0;

        for num in nums {
            for s in (num..=target).rev() {
                if dp[(s - num) as usize] != -1 {
                    dp[s as usize] = dp[s as usize].max(dp[(s - num) as usize] + 1);
                }
            }
        }

        dp[target as usize]
    }
}