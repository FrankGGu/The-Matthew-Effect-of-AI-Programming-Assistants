impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn knight_probability(n: i32, k: i32, row: i32, column: i32) -> f64 {
        let mut dp = vec![vec![0.0; n as usize]; n as usize];
        dp[row as usize][column as usize] = 1.0;

        let directions = [(-2, -1), (-2, 1), (-1, -2), (-1, 2),
                          (1, -2), (1, 2), (2, -1), (2, 1)];

        for _ in 0..k {
            let mut next_dp = vec![vec![0.0; n as usize]; n as usize];
            for i in 0..n as usize {
                for j in 0..n as usize {
                    if dp[i][j] > 0.0 {
                        for &(dx, dy) in &directions {
                            let ni = i as i32 + dx;
                            let nj = j as i32 + dy;
                            if ni >= 0 && ni < n && nj >= 0 && nj < n {
                                next_dp[ni as usize][nj as usize] += dp[i][j] / 8.0;
                            }
                        }
                    }
                }
            }
            dp = next_dp;
        }

        let mut total = 0.0;
        for i in 0..n as usize {
            for j in 0..n as usize {
                total += dp[i][j];
            }
        }
        total
    }
}
}