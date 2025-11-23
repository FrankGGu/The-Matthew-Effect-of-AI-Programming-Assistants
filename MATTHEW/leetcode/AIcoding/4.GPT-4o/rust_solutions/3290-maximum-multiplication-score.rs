impl Solution {
    pub fn maximum_multiplication_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in (0..m).rev() {
            for j in 0..=i {
                let left = dp[j][i + 1] + nums[j] * multipliers[i];
                let right = dp[j][i + 1] + nums[n - 1 - (i - j)] * multipliers[i];
                dp[j][i] = left.max(right);
            }
        }

        dp[0][0]
    }
}