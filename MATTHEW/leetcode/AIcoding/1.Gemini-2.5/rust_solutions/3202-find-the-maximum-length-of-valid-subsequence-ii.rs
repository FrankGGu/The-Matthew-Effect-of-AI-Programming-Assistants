impl Solution {
    pub fn longest_valid_subsequence(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut dp = vec![1; n];
        let mut max_len = 1;

        for i in 0..n {
            for j in 0..i {
                let sum = nums[j] + nums[i];
                let root = (sum as f64).sqrt() as i32;
                if root * root == sum {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
            max_len = max_len.max(dp[i]);
        }

        max_len
    }
}