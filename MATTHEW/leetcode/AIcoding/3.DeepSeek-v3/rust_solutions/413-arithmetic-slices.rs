impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }
        let mut dp = vec![0; n];
        let mut res = 0;
        for i in 2..n {
            if nums[i] - nums[i - 1] == nums[i - 1] - nums[i - 2] {
                dp[i] = dp[i - 1] + 1;
                res += dp[i];
            }
        }
        res
    }
}