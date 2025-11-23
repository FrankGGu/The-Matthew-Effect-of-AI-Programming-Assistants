impl Solution {
    pub fn maximize_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in (0..m).rev() {
            for j in 0..=i {
                let left = nums[j] * multipliers[i] + dp[i + 1][j + 1];
                let right = nums[n - 1 - (i - j)] * multipliers[i] + dp[i + 1][j];
                dp[i][j] = left.max(right);
            }
        }

        dp[0][0]
    }
}