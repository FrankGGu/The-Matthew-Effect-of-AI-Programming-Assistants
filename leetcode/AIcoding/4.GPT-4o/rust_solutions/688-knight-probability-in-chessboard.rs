impl Solution {
    pub fn knight_probability(n: i32, k: i32, row: i32, col: i32) -> f64 {
        let directions = vec![(2, 1), (2, -1), (-2, 1), (-2, -1), (1, 2), (1, -2), (-1, 2), (-1, -2)];
        let mut dp = vec![vec![vec![0.0; n as usize]; n as usize]; (k + 1) as usize];
        dp[0][row as usize][col as usize] = 1.0;

        for step in 1..=k {
            for r in 0..n {
                for c in 0..n {
                    for &(dr, dc) in &directions {
                        let nr = r + dr;
                        let nc = c + dc;
                        if nr >= 0 && nr < n && nc >= 0 && nc < n {
                            dp[step as usize][nr as usize][nc as usize] += dp[(step - 1) as usize][r as usize][c as usize] / 8.0;
                        }
                    }
                }
            }
        }

        let mut probability = 0.0;
        for r in 0..n {
            for c in 0..n {
                probability += dp[k as usize][r as usize][c as usize];
            }
        }
        probability
    }
}