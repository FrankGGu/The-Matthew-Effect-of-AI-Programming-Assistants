impl Solution {
    pub fn max_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for op in (0..m).rev() {
            for left in (0..=op).rev() {
                let right = n - 1 - (op - left);
                let pick_left = nums[left] * multipliers[op] + dp[op + 1][left + 1];
                let pick_right = nums[right] * multipliers[op] + dp[op + 1][left];
                dp[op][left] = pick_left.max(pick_right);
            }
        }

        dp[0][0]
    }
}