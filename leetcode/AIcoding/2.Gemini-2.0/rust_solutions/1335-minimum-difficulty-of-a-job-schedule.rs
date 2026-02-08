impl Solution {
    pub fn min_difficulty(job_difficulty: Vec<i32>, d: i32) -> i32 {
        let n = job_difficulty.len();
        if n < d as usize {
            return -1;
        }

        let mut dp = vec![vec![i32::MAX; n + 1]; (d + 1) as usize];
        dp[0][n] = 0;

        for i in 1..=d {
            for j in (0..n).rev() {
                let mut max_difficulty = 0;
                for k in j..n {
                    max_difficulty = max_difficulty.max(job_difficulty[k]);
                    if dp[(i - 1) as usize][k + 1] != i32::MAX {
                        dp[i as usize][j] = dp[i as usize][j].min(max_difficulty + dp[(i - 1) as usize][k + 1]);
                    }
                }
            }
        }

        dp[d as usize][0]
    }
}