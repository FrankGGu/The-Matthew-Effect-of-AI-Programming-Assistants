impl Solution {
    pub fn minimum_white_tiles(tiles: String, carpet_len: i32) -> i32 {
        let n = tiles.len();
        let tiles: Vec<i32> = tiles.chars().map(|c| c.to_digit(10).unwrap() as i32).collect();
        let carpet_len = carpet_len as usize;
        let mut dp = vec![vec![0; n + 1]; n + 1];

        for i in 1..=n {
            for j in 0..=i {
                if j == 0 {
                    dp[i][j] = dp[i - 1][j] + tiles[i - 1];
                } else {
                    dp[i][j] = (dp[i - 1][j] + tiles[i - 1]).min(dp[std::cmp::max(0, i as i32 - carpet_len as i32) as usize][j - 1]);
                }
            }
        }

        dp[n][n]
    }
}