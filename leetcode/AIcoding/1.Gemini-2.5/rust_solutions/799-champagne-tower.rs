impl Solution {
    pub fn champagne_tower(poured: i32, query_row: i32, query_glass: i32) -> f64 {
        let max_rows = query_row as usize + 1;
        let mut dp = vec![vec![0.0; max_rows]; max_rows];

        dp[0][0] = poured as f64;

        for r in 0..query_row as usize {
            for c in 0..=r {
                if dp[r][c] > 1.0 {
                    let overflow = dp[r][c] - 1.0;
                    dp[r + 1][c] += overflow / 2.0;
                    dp[r + 1][c + 1] += overflow / 2.0;
                }
            }
        }

        dp[query_row as usize][query_glass as usize].min(1.0)
    }
}