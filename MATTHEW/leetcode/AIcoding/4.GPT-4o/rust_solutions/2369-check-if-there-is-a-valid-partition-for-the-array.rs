impl Solution {
    pub fn valid_partition(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut dp = vec![false; n + 1];
        dp[0] = true;

        for i in 2..=n {
            if nums[i - 1] == nums[i - 2] {
                dp[i] |= dp[i - 2];
            }
            if i > 2 && nums[i - 1] == nums[i - 2] && nums[i - 2] == nums[i - 3] {
                dp[i] |= dp[i - 3];
            }
            if i > 1 && nums[i - 1] == nums[i - 2] + 1 && nums[i - 2] == nums[i - 3] + 1 {
                dp[i] |= dp[i - 2];
            }
        }

        dp[n]
    }
}