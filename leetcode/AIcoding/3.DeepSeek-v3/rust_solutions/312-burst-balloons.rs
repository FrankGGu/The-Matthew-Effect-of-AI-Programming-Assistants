impl Solution {
    pub fn max_coins(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut new_nums = vec![1; n + 2];
        for i in 0..n {
            new_nums[i + 1] = nums[i];
        }
        let n = new_nums.len();
        let mut dp = vec![vec![0; n]; n];

        for len in 2..n {
            for left in 0..n - len {
                let right = left + len;
                for i in left + 1..right {
                    dp[left][right] = dp[left][right].max(
                        new_nums[left] * new_nums[i] * new_nums[right] + dp[left][i] + dp[i][right]
                    );
                }
            }
        }
        dp[0][n - 1]
    }
}