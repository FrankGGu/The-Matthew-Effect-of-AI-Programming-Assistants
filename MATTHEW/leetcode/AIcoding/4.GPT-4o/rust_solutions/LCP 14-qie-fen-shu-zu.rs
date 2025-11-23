impl Solution {
    pub fn can_split_array(nums: Vec<i32>, m: i32) -> bool {
        if nums.len() < 3 {
            return true;
        }
        let mut dp = vec![false; nums.len()];
        dp[0] = true;
        dp[1] = (nums[0] + nums[1]) <= m;

        for i in 2..nums.len() {
            if dp[i - 1] && nums[i] <= m {
                dp[i] = true;
            }
            if dp[i - 2] && (nums[i - 1] + nums[i]) <= m {
                dp[i] = true;
            }
        }
        dp[nums.len() - 1]
    }
}