impl Solution {
    pub fn num_ways(words: Vec<String>, target: String) -> i32 {
        let modulo = 1_000_000_007;

        let num_target_chars = target.len();
        let num_word_cols = words[0].len();

        let mut counts: Vec<Vec<i64>> = vec![vec![0; num_word_cols]; 26];

        for word_str in words.iter() {
            let word_chars: Vec<char> = word_str.chars().collect();
            for j in 0..num_word_cols {
                let char_code = (word_chars[j] as u8 - b'a') as usize;
                counts[char_code][j] += 1;
            }
        }

        let target_chars: Vec<char> = target.chars().collect();

        // dp[j] stores the number of ways to form the prefix target[0...i-1]
        // using characters from columns 0...j-1.
        // Initially, dp represents dp[0][j], which is 1 for forming an empty prefix.
        let mut dp: Vec<i64> = vec![1; num_word_cols + 1];

        for i in 0..num_target_chars {
            let char_to_match_code = (target_chars[i] as u8 - b'a') as usize;

            // prev_dp_prev_col stores dp[i-1][j-1] from the previous iteration of j.
            // At the start of the j loop (j=1), this holds dp[i-1][0].
            let mut prev_dp_prev_col = dp[0]; 

            // For i > 0, dp[i][0] (ways to form a non-empty prefix using 0 columns) is 0.
            dp[0] = 0; 

            for j in 1..=num_word_cols {
                // current_dp_val stores dp[i-1][j] before dp[j] is updated to dp[i][j].
                let current_dp_val = dp[j]; 

                // Ways to form target[0...i] using columns 0...j:
                // 1. Don't use column j-1 for target[i].
                //    This is dp[i][j-1], which is dp[j-1] after it's been updated in this row.
                // 2. Use column j-1 for target[i].
                //    This requires forming target[0...i-1] using columns 0...j-2 (prev_dp_prev_col, which is dp[i-1][j-1])
                //    multiplied by the number of times target[i] appears in column j-1 (counts[char_to_match_code][j-1]).
                let ways_using_current_col = (prev_dp_prev_col * counts[char_to_match_code][j-1]) % modulo;

                dp[j] = (dp[j-1] + ways_using_current_col) % modulo;

                // Update prev_dp_prev_col for the next iteration of j.
                // It should hold dp[i-1][j] for the next j.
                prev_dp_prev_col = current_dp_val; 
            }
        }

        dp[num_word_cols] as i32
    }
}