impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i64 {
        let rows = points.len();
        let cols = points[0].len();

        let mut prev_dp: Vec<i64> = points[0].iter().map(|&x| x as i64).collect();

        for i in 1..rows {
            let mut curr_dp = vec![0i64; cols];
            let mut left_max = vec![0i64; cols];
            let mut right_max = vec![0i64; cols];

            left_max[0] = prev_dp[0] + 0;
            for j in 1..cols {
                left_max[j] = left_max[j - 1].max(prev_dp[j] + j as i64);
            }

            right_max[cols - 1] = prev_dp[cols - 1] - (cols - 1) as i64;
            for j in (0..cols - 1).rev() {
                right_max[j] = right_max[j + 1].max(prev_dp[j] - j as i64);
            }

            for j in 0..cols {
                curr_dp[j] = points[i][j] as i64 + (left_max[j] - j as i64).max(right_max[j] + j as i64);
            }

            prev_dp = curr_dp;
        }

        *prev_dp.iter().max().unwrap_or(&0)
    }
}