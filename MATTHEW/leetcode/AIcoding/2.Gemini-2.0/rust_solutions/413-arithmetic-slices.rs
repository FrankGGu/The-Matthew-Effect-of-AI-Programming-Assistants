impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }

        let mut dp = vec![0; n];
        let mut ans = 0;

        for i in 2..n {
            if nums[i] as i64 - nums[i - 1] as i64 == nums[i - 1] as i64 - nums[i - 2] as i64 {
                dp[i] = dp[i - 1] + 1;
                ans += dp[i];
            }
        }

        ans
    }
}