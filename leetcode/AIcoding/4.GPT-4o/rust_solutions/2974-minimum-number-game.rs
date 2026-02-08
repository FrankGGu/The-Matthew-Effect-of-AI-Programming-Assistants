impl Solution {
    pub fn min_number_game(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = nums.clone();

        for i in (0..n-1).rev() {
            for j in (0..=i).step_by(2) {
                dp[j] = dp[j].min(dp[j + 1]);
            }
        }

        dp[0]
    }
}