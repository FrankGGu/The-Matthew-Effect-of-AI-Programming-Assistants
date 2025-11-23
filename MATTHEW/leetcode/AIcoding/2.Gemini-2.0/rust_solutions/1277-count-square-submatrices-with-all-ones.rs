impl Solution {
    pub fn count_squares(matrix: Vec<Vec<i32>>) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == 1 {
                    if i == 0 || j == 0 {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = 1 + std::cmp::min(dp[i - 1][j], std::cmp::min(dp[i][j - 1], dp[i - 1][j - 1]));
                    }
                    count += dp[i][j];
                }
            }
        }

        count
    }
}