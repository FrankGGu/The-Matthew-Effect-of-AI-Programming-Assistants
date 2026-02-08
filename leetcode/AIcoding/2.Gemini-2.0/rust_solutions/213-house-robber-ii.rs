impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0];
        }
        if n == 2 {
            return nums[0].max(nums[1]);
        }

        fn helper(nums: &[i32]) -> i32 {
            let n = nums.len();
            let mut dp = vec![0; n];
            dp[0] = nums[0];
            dp[1] = nums[0].max(nums[1]);
            for i in 2..n {
                dp[i] = dp[i - 1].max(dp[i - 2] + nums[i]);
            }
            dp[n - 1]
        }

        helper(&nums[0..n - 1]).max(helper(&nums[1..n]))
    }
}