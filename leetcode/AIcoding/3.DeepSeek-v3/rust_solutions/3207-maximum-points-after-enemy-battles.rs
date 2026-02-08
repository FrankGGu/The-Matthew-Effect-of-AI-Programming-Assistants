impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
        let m = points.len();
        let n = points[0].len();
        let mut dp = vec![vec![0; n]; m];

        for j in 0..n {
            dp[0][j] = points[0][j];
        }

        for i in 1..m {
            let mut left = vec![0; n];
            left[0] = dp[i-1][0];
            for j in 1..n {
                left[j] = left[j-1].max(dp[i-1][j] + j as i32);
            }

            let mut right = vec![0; n];
            right[n-1] = dp[i-1][n-1] - (n-1) as i32;
            for j in (0..n-1).rev() {
                right[j] = right[j+1].max(dp[i-1][j] - j as i32);
            }

            for j in 0..n {
                dp[i][j] = points[i][j] + (left[j] - j as i32).max(right[j] + j as i32);
            }
        }

        *dp[m-1].iter().max().unwrap()
    }
}