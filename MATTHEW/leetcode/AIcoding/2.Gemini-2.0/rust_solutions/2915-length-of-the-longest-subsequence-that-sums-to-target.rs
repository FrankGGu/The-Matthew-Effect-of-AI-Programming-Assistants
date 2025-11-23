impl Solution {
    pub fn length_of_longest_subsequence(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![-1; target as usize + 1]; n + 1];
        for i in 0..=n {
            dp[i][0] = 0;
        }
        for i in 1..=n {
            for j in 1..=target as usize {
                if nums[i - 1] as usize <= j {
                    dp[i][j] = std::cmp::max(dp[i - 1][j], dp[i - 1][j - nums[i - 1] as usize] + 1);
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }
        if dp[n][target as usize] == -1 {
            -1
        } else {
            dp[n][target as usize]
        }
    }
}