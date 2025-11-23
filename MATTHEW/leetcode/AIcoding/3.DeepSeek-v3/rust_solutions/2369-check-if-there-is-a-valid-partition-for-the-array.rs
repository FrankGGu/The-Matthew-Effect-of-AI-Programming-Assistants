impl Solution {
    pub fn valid_partition(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n == 0 {
            return false;
        }
        let mut dp = vec![false; n + 1];
        dp[0] = true;

        for i in 2..=n {
            if nums[i - 1] == nums[i - 2] {
                dp[i] = dp[i] || dp[i - 2];
            }
            if i >= 3 {
                if (nums[i - 1] == nums[i - 2] && nums[i - 2] == nums[i - 3]) ||
                   (nums[i - 1] == nums[i - 2] + 1 && nums[i - 2] == nums[i - 3] + 1) {
                    dp[i] = dp[i] || dp[i - 3];
                }
            }
        }

        dp[n]
    }
}