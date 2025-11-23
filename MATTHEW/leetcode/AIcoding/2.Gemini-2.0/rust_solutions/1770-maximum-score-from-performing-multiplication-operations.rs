impl Solution {
    pub fn maximum_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in (0..=m).rev() {
            for left in (0..=i).rev() {
                if i == m {
                    dp[left][i] = 0;
                } else {
                    let right = n - 1 - (i - left);
                    dp[left][i] = multipliers[i] * nums[left] + dp[left + 1][i + 1];
                    dp[left][i] = dp[left][i].max(multipliers[i] * nums[right] + dp[left][i + 1]);
                }
            }
        }

        dp[0][0]
    }
}