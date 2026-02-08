impl Solution {
    pub fn minimum_white_tiles(tiles: String, num_carpets: i32, carpet_len: i32) -> i32 {
        let n = tiles.len();
        let num_carpets = num_carpets as usize;
        let carpet_len = carpet_len as usize;
        let tiles_chars: Vec<char> = tiles.chars().collect();

        let mut prefix_sum_white = vec![0; n + 1];
        for i in 0..n {
            prefix_sum_white[i + 1] = prefix_sum_white[i] + (if tiles_chars[i] == '1' { 1 } else { 0 });
        }

        let mut dp = vec![vec![usize::MAX / 2; num_carpets + 1]; n + 1];

        for j in 0..=num_carpets {
            dp[0][j] = 0;
        }

        for i in 0..=n {
            dp[i][0] = prefix_sum_white[i];
        }

        for i in 1..=n {
            for j in 1..=num_carpets {
                // Option 1: Don't use a carpet ending at i-1.
                // If tiles[i-1] is '1', it remains uncovered.
                let option1 = dp[i - 1][j] + (if tiles_chars[i - 1] == '1' { 1 } else { 0 });

                // Option 2: Use a carpet ending at i-1.
                // This carpet covers tiles from max(0, i - carpet_len) to i-1.
                // The state before placing this carpet would be dp[max(0, i - carpet_len)][j-1].
                let prev_idx = if i >= carpet_len { i - carpet_len } else { 0 };
                let option2 = dp[prev_idx][j - 1];

                dp[i][j] = option1.min(option2);
            }
        }

        dp[n][num_carpets] as i32
    }
}