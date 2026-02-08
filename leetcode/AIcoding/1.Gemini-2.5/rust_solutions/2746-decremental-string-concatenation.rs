impl Solution {
    pub fn minimize_concatenated_length(words: Vec<String>) -> i32 {
        let n = words.len();
        if n == 0 {
            return 0;
        }

        // dp[i][j] represents the minimum cost to concatenate words[0...i] (inclusive),
        // such that the resulting string ends with the character corresponding to j.
        // j is an integer from 0 to 25, mapping 'a' to 0, 'b' to 1, ..., 'z' to 25.
        let mut dp = vec![vec![usize::MAX; 26]; n];

        // Base case: For the first word words[0]
        let first_word = &words[0];
        let first_word_len = first_word.len();
        let first_word_last_char_idx = first_word.chars().last().unwrap() as usize - 'a' as usize;
        dp[0][first_word_last_char_idx] = first_word_len;

        // Iterate through the words from the second word (index 1)
        for i in 1..n {
            let current_word = &words[i];
            let current_word_first_char = current_word.chars().next().unwrap();
            let current_word_last_char_idx = current_word.chars().last().unwrap() as usize - 'a' as usize;
            let current_word_len = current_word.len();

            // Iterate through all possible last characters of the string formed by words[0...i-1]
            for prev_last_char_idx in 0..26 {
                // If the previous state is unreachable, skip it
                if dp[i - 1][prev_last_char_idx] == usize::MAX {
                    continue;
                }

                let prev_last_char = (prev_last_char_idx as u8 + b'a') as char;

                // Calculate the cost to add the current_word to the string ending with prev_last_char
                let mut cost_to_add_current_word = current_word_len;
                // The problem implies a simplified overlap: if the last character of the
                // previous string matches the first character of the current word,
                // then there's an overlap of 1 character. Otherwise, no overlap.
                if prev_last_char == current_word_first_char {
                    cost_to_add_current_word -= 1; // Decrement cost by 1 for the overlap
                }

                let new_total_cost = dp[i - 1][prev_last_char_idx] + cost_to_add_current_word;

                // Update the DP table for the current word, which will end with its own last character
                dp[i][current_word_last_char_idx] = dp[i][current_word_last_char_idx].min(new_total_cost);
            }
        }

        // The minimum total cost is the minimum value in the last row of the DP table
        let mut min_total_cost = usize::MAX;
        for j in 0..26 {
            min_total_cost = min_total_cost.min(dp[n - 1][j]);
        }

        min_total_cost as i32
    }
}