impl Solution {
    pub fn maximum_length(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut dp = vec![vec![0; k + 1]; n];
        let mut res = 1;

        for i in 0..n {
            for j in 0..=k {
                dp[i][j] = 1;
                for prev in 0..i {
                    if nums[prev] == nums[i] {
                        dp[i][j] = dp[i][j].max(dp[prev][j] + 1);
                    } else if j > 0 {
                        dp[i][j] = dp[i][j].max(dp[prev][j - 1] + 1);
                    }
                }
                res = res.max(dp[i][j]);
            }
        }

        res
    }
}