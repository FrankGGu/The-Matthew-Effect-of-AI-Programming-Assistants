impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let m = points[0].len();
        let mut dp = vec![0; m];

        for i in 0..n {
            let mut left = vec![0; m];
            let mut right = vec![0; m];

            left[0] = dp[0];
            for j in 1..m {
                left[j] = left[j - 1].max(dp[j] + j as i32);
            }

            right[m - 1] = dp[m - 1];
            for j in (0..m - 1).rev() {
                right[j] = right[j + 1].max(dp[j] - j as i32);
            }

            for j in 0..m {
                dp[j] = points[i][j] + left[j].max(right[j]);
            }
        }

        *dp.iter().max().unwrap()
    }
}