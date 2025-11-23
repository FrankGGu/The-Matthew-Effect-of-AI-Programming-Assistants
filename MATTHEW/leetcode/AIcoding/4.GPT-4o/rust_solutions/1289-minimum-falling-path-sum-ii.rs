impl Solution {
    pub fn min_falling_path_sum(matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        let m = matrix[0].len();
        let mut dp = matrix.clone();

        for i in (1..n).rev() {
            for j in 0..m {
                dp[i][j] += (0..m)
                    .filter(|&k| k != j)
                    .map(|k| dp[i + 1][k])
                    .min()
                    .unwrap();
            }
        }

        dp[0].iter().cloned().min().unwrap()
    }
}