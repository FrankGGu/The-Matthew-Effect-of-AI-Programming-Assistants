impl Solution {
    pub fn min_difficulty(job_difficulty: Vec<i32>, d: i32) -> i32 {
        let n = job_difficulty.len();
        if n < d as usize { return -1; }

        let mut dp = vec![vec![i32::MAX; d as usize + 1]; n + 1];
        dp[0][0] = 0;

        for day in 1..=d as usize {
            for i in day..=n {
                let mut max_difficulty = 0;
                for j in (day..=i).rev() {
                    max_difficulty = max_difficulty.max(job_difficulty[j - 1]);
                    dp[i][day] = dp[i][day].min(dp[j - 1][day - 1] + max_difficulty);
                }
            }
        }

        dp[n][d as usize]
    }
}