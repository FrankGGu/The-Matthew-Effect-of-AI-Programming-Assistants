pub struct Solution {}

impl Solution {
    pub fn length_of_largest_square(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut max_side = 0;

        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == 1 {
                    if i == 0 || j == 0 {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = std::cmp::min(dp[i - 1][j - 1], std::cmp::min(dp[i - 1][j], dp[i][j - 1])) + 1;
                    }
                    max_side = std::cmp::max(max_side, dp[i][j]);
                }
            }
        }

        max_side
    }
}