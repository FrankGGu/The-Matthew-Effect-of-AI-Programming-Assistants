impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=n-len {
                let j = i + len - 1;
                if nums[i] == nums[j] {
                    dp[i][j] = if len > 2 { dp[i+1][j-1] } else { 0 };
                } else {
                    dp[i][j] = 1 + std::cmp::min(dp[i+1][j], dp[i][j-1]);
                }
            }
        }

        dp[0][n-1]
    }
}