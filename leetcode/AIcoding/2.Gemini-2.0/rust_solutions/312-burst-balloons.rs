impl Solution {
    pub fn max_coins(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut nums = nums;
        nums.insert(0, 1);
        nums.push(1);

        let mut dp = vec![vec![0; n + 2]; n + 2];

        for len in 2..=n + 1 {
            for i in 0..=n - len + 1 {
                let j = i + len;
                for k in i + 1..j {
                    dp[i][j] = dp[i][j].max(dp[i][k] + dp[k][j] + nums[i] * nums[k] * nums[j]);
                }
            }
        }

        dp[0][n + 1]
    }
}