impl Solution {
    pub fn minimum_distance(word: String) -> i32 {
        let n = word.len();
        let word_bytes = word.as_bytes();
        let mut dp = vec![vec![vec![i32::MAX; 27]; 27]; n + 1];
        dp[0][26][26] = 0;

        for i in 0..n {
            let current_char = (word_bytes[i] - b'A') as usize;
            for left in 0..27 {
                for right in 0..27 {
                    if dp[i][left][right] != i32::MAX {
                        let cost_left = if left == 26 {
                            0
                        } else {
                            let left_row = left / 6;
                            let left_col = left % 6;
                            let current_row = current_char / 6;
                            let current_col = current_char % 6;
                            (left_row as i32 - current_row as i32).abs() + (left_col as i32 - current_col as i32).abs()
                        };
                        let cost_right = if right == 26 {
                            0
                        } else {
                            let right_row = right / 6;
                            let right_col = right % 6;
                            let current_row = current_char / 6;
                            let current_col = current_char % 6;
                            (right_row as i32 - current_row as i32).abs() + (right_col as i32 - current_col as i32).abs()
                        };

                        dp[i + 1][current_char][right] =
                            dp[i + 1][current_char][right].min(dp[i][left][right] + cost_left);
                        dp[i + 1][left][current_char] =
                            dp[i + 1][left][current_char].min(dp[i][left][right] + cost_right);
                    }
                }
            }
        }

        let mut min_dist = i32::MAX;
        for left in 0..27 {
            for right in 0..27 {
                min_dist = min_dist.min(dp[n][left][right]);
            }
        }

        min_dist
    }
}