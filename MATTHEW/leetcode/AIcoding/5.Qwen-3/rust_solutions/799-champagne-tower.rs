struct Solution;

impl Solution {
    pub fn champagne_placement(tower: Vec<Vec<i32>>, k: i32, row: i32, col: i32) -> f64 {
        let mut dp = vec![vec![0.0; 1]; 1];
        for i in 0..=row as usize {
            dp.push(vec![0.0; i + 2]);
        }
        dp[0][0] = tower[0][0] as f64;
        for i in 0..=row as usize {
            for j in 0..=i {
                if dp[i][j] > 1.0 {
                    let overflow = dp[i][j] - 1.0;
                    dp[i + 1][j] += overflow / 2.0;
                    dp[i + 1][j + 1] += overflow / 2.0;
                }
            }
        }
        dp[row as usize][col as usize]
    }
}