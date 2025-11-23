impl Solution {
    pub fn knight_probability(n: i32, k: i32, row: i32, column: i32) -> f64 {
        let n_usize = n as usize;
        let k_usize = k as usize;

        let moves: [(i32, i32); 8] = [
            (-2, -1), (-2, 1), (-1, -2), (-1, 2),
            (1, -2), (1, 2), (2, -1), (2, 1),
        ];

        let mut dp: Vec<Vec<f64>> = vec![vec![0.0; n_usize]; n_usize];
        dp[row as usize][column as usize] = 1.0;

        for _step in 0..k_usize {
            let mut next_dp: Vec<Vec<f64>> = vec![vec![0.0; n_usize]; n_usize];
            for r in 0..n_usize {
                for c in 0..n_usize {
                    if dp[r][c] > 0.0 {
                        for &(dr, dc) in moves.iter() {
                            let nr = r as i32 + dr;
                            let nc = c as i32 + dc;

                            if nr >= 0 && nr < n && nc >= 0 && nc < n {
                                next_dp[nr as usize][nc as usize] += dp[r][c] * 0.125;
                            }
                        }
                    }
                }
            }
            dp = next_dp;
        }

        let mut total_probability = 0.0;
        for r in 0..n_usize {
            for c in 0..n_usize {
                total_probability += dp[r][c];
            }
        }

        total_probability
    }
}