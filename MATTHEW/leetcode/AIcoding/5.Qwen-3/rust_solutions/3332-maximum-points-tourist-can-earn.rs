impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_points(mut points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let m = points[0].len();

        for i in 1..n {
            for j in 0..m {
                let mut max_prev = 0;
                for k in 0..m {
                    if k != j {
                        max_prev = max(max_prev, points[i - 1][k]);
                    }
                }
                points[i][j] += max_prev;
            }
        }

        *points[n - 1].iter().max().unwrap()
    }
}
}