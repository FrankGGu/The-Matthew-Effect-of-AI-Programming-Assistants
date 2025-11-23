impl Solution {
    pub fn min_falling_path_sum(matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        let mut dp = matrix.clone();

        for i in 1..n {
            for j in 0..n {
                let mut min_prev = dp[i-1][j];
                if j > 0 {
                    min_prev = min_prev.min(dp[i-1][j-1]);
                }
                if j < n - 1 {
                    min_prev = min_prev.min(dp[i-1][j+1]);
                }
                dp[i][j] += min_prev;
            }
        }

        *dp[n-1].iter().min().unwrap()
    }
}