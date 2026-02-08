impl Solution {
    pub fn maximal_square(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut dp = vec![vec![0; cols + 1]; rows + 1];
        let mut max_side = 0;

        for i in 1..=rows {
            for j in 1..=cols {
                if matrix[i - 1][j - 1] == '1' {
                    dp[i][j] = dp[i - 1][j].min(dp[i][j - 1]).min(dp[i - 1][j - 1]) + 1;
                    max_side = max_side.max(dp[i][j]);
                }
            }
        }

        max_side * max_side
    }
}