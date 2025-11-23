impl Solution {
    pub fn max_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in (0..m).rev() {
            for left in (0..=i).rev() {
                let right = n as i32 - 1 - (i as i32 - left as i32);
                dp[left as usize][i + 1] = dp[left as usize][i] 
                    .max(dp[left as usize + 1][i] + nums[left as usize] * multipliers[i])
                    .max(dp[left as usize][i + 1] + nums[right as usize] * multipliers[i]);
            }
        }

        dp[0][m]
    }
}