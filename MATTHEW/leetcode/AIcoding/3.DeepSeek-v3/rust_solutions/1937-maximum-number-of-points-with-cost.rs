impl Solution {
    pub fn max_points(points: Vec<Vec<i32>>) -> i64 {
        let m = points.len();
        let n = points[0].len();
        let mut dp_prev = vec![0i64; n];
        for j in 0..n {
            dp_prev[j] = points[0][j] as i64;
        }

        for i in 1..m {
            let mut left = vec![0i64; n];
            left[0] = dp_prev[0];
            for j in 1..n {
                left[j] = std::cmp::max(left[j - 1] - 1, dp_prev[j]);
            }

            let mut right = vec![0i64; n];
            right[n - 1] = dp_prev[n - 1];
            for j in (0..n - 1).rev() {
                right[j] = std::cmp::max(right[j + 1] - 1, dp_prev[j]);
            }

            let mut dp_curr = vec![0i64; n];
            for j in 0..n {
                dp_curr[j] = points[i][j] as i64 + std::cmp::max(left[j], right[j]);
            }
            dp_prev = dp_curr;
        }

        *dp_prev.iter().max().unwrap()
    }
}