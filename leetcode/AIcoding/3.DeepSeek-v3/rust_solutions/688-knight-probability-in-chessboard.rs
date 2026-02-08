impl Solution {
    pub fn knight_probability(n: i32, k: i32, row: i32, column: i32) -> f64 {
        let dirs = [
            (-2, -1), (-2, 1), (-1, -2), (-1, 2),
            (1, -2), (1, 2), (2, -1), (2, 1)
        ];
        let n = n as usize;
        let k = k as usize;
        let row = row as usize;
        let column = column as usize;
        let mut dp = vec![vec![vec![0.0; n]; n]; k + 1];
        dp[0][row][column] = 1.0;

        for step in 1..=k {
            for i in 0..n {
                for j in 0..n {
                    for &(dx, dy) in dirs.iter() {
                        let x = i as i32 + dx;
                        let y = j as i32 + dy;
                        if x >= 0 && x < n as i32 && y >= 0 && y < n as i32 {
                            dp[step][x as usize][y as usize] += dp[step - 1][i][j] / 8.0;
                        }
                    }
                }
            }
        }

        dp[k].iter().map(|row| row.iter().sum::<f64>()).sum()
    }
}