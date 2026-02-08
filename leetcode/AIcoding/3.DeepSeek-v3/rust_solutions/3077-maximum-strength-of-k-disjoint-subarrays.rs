impl Solution {
    pub fn maximum_strength(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![std::i64::MIN / 2; k + 1]; n + 1];
        let mut res = std::i64::MIN;
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k {
                if j == 0 {
                    dp[i][j] = 0;
                } else {
                    let mut max_prev = std::i64::MIN / 2;
                    for l in 0..i {
                        max_prev = max_prev.max(dp[l][j - 1]);
                    }
                    dp[i][j] = (dp[i - 1][j].max(max_prev)) as i64 + nums[i - 1] as i64 * (j as i64) * if j % 2 == 1 { 1 } else { -1 };
                }
                if j == k {
                    res = res.max(dp[i][j]);
                }
            }
        }

        res
    }
}