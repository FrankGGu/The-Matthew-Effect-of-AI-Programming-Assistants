impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i64 {
        let m = points.len();
        let n = points[0].len();
        let mut dp = vec![0; n];

        for i in 0..n {
            dp[i] = points[0][i] as i64;
        }

        for i in 1..m {
            let mut left = vec![0; n];
            let mut right = vec![0; n];

            left[0] = dp[0];
            for j in 1..n {
                left[j] = std::cmp::max(left[j - 1] - 1, dp[j]);
            }

            right[n - 1] = dp[n - 1];
            for j in (0..n - 1).rev() {
                right[j] = std::cmp::max(right[j + 1] - 1, dp[j]);
            }

            for j in 0..n {
                dp[j] = std::cmp::max(left[j], right[j]) + points[i][j] as i64;
            }
        }

        *dp.iter().max().unwrap()
    }
}