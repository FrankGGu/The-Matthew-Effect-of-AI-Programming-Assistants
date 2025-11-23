impl Solution {
    pub fn knight_probability(n: i32, k: i32, row: i32, column: i32) -> f64 {
        let n = n as usize;
        let k = k as usize;
        let row = row as usize;
        let column = column as usize;

        let mut dp = vec![vec![0.0; n]; n];
        dp[row][column] = 1.0;

        let moves: [(i32, i32); 8] = [
            (-2, -1), (-2, 1), (-1, -2), (-1, 2),
            (1, -2), (1, 2), (2, -1), (2, 1),
        ];

        for _ in 0..k {
            let mut next_dp = vec![vec![0.0; n]; n];
            for i in 0..n {
                for j in 0..n {
                    for &(dx, dy) in &moves {
                        let next_x = i as i32 + dx;
                        let next_y = j as i32 + dy;

                        if next_x >= 0 && next_x < n as i32 && next_y >= 0 && next_y < n as i32 {
                            next_dp[next_x as usize][next_y as usize] += dp[i][j] / 8.0;
                        }
                    }
                }
            }
            dp = next_dp;
        }

        let mut total_probability = 0.0;
        for i in 0..n {
            for j in 0..n {
                total_probability += dp[i][j];
            }
        }

        total_probability
    }
}