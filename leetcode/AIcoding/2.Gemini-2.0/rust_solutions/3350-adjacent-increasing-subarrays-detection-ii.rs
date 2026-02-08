impl Solution {
    pub fn adjacent_increasing_subarrays(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut ans = 0;
        for i in 0..n {
            if i > 0 && nums[i] > nums[i - 1] {
                dp[i] = dp[i - 1] + 1;
            } else {
                dp[i] = 0;
            }
            ans += dp[i] as i64;
        }
        ans
    }
}