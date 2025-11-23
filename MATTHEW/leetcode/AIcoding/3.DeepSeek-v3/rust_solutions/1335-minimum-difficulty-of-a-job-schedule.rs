impl Solution {
    pub fn min_difficulty(job_difficulty: Vec<i32>, d: i32) -> i32 {
        let n = job_difficulty.len();
        let d = d as usize;
        if n < d {
            return -1;
        }
        let mut dp = vec![vec![i32::MAX; d + 1]; n + 1];
        dp[0][0] = 0;
        for i in 1..=n {
            for k in 1..=d {
                let mut max_difficulty = 0;
                for j in (k - 1..i).rev() {
                    max_difficulty = max_difficulty.max(job_difficulty[j]);
                    if dp[j][k - 1] != i32::MAX {
                        dp[i][k] = dp[i][k].min(dp[j][k - 1] + max_difficulty);
                    }
                }
            }
        }
        dp[n][d]
    }
}