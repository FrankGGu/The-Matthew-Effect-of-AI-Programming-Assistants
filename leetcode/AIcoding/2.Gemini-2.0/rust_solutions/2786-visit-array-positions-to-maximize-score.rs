impl Solution {
    pub fn max_score(nums: Vec<i32>, x: i32) -> i64 {
        let n = nums.len();
        let mut dp = vec![vec![std::i64::MIN; 2]; n];

        dp[0][nums[0] as i64 % 2 as usize] = nums[0] as i64;

        for i in 1..n {
            let curr_parity = nums[i] as i64 % 2 as usize;
            for prev_parity in 0..2 {
                let cost = if curr_parity == prev_parity {
                    0
                } else {
                    -x as i64
                };

                dp[i][curr_parity] = dp[i][curr_parity].max(dp[i - 1][prev_parity] + nums[i] as i64 + cost);
            }
        }

        dp[n - 1][0].max(dp[n - 1][1])
    }
}