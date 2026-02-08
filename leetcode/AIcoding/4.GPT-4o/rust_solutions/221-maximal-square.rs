impl Solution {
    pub fn maximal_square(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut dp = vec![vec![0; n + 1]; m + 1];
        let mut max_side = 0;

        for i in 1..=m {
            for j in 1..=n {
                if matrix[i - 1][j - 1] == '1' {
                    dp[i][j] = dp[i - 1][j - 1].min(dp[i - 1][j]).min(dp[i][j - 1]) + 1;
                    max_side = max_side.max(dp[i][j]);
                }
            }
        }

        max_side * max_side
    }
}