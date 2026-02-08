impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let m = points[0].len();
        let mut dp = vec![0; m];

        for i in 0..n {
            let mut new_dp = vec![0; m];
            let mut left_max = vec![0; m];
            let mut right_max = vec![0; m];

            left_max[0] = dp[0];
            for j in 1..m {
                left_max[j] = left_max[j - 1].max(dp[j] - j as i32);
            }

            right_max[m - 1] = dp[m - 1];
            for j in (0..m - 1).rev() {
                right_max[j] = right_max[j + 1].max(dp[j] - (m - 1 - j) as i32);
            }

            for j in 0..m {
                new_dp[j] = points[i][j] + left_max[j] + right_max[j];
            }

            dp = new_dp;
        }

        *dp.iter().max().unwrap()
    }
}