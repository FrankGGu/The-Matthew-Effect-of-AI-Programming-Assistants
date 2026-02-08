impl Solution {
    pub fn minimum_number_of_valid_strings_to_form_target_i(words: Vec<String>, target: String) -> i32 {
        let n = target.len();
        // dp[i] stores the minimum number of words to form the prefix target[0...i-1]
        // Initialize with n + 1, which signifies an unreachable state (more than max possible words)
        let mut dp = vec![n + 1; n + 1];

        // Base case: 0 words are needed to form an empty string
        dp[0] = 0;

        // Iterate through all possible end positions of a prefix in target
        for i in 1..=n {
            // For each word in the given list
            for word in &words {
                let word_len = word.len();
                // If the current prefix length `i` is at least the length of the word
                if i >= word_len {
                    // Check if the substring of target ending at `i-1` and having length `word_len`
                    // matches the current word
                    if &target[i - word_len..i] == word {
                        // If it matches, we can potentially form target[0...i-1]
                        // by forming target[0...i-word_len-1] and then appending this word.
                        // Update dp[i] with the minimum count.
                        dp[i] = dp[i].min(dp[i - word_len] + 1);
                    }
                }
            }
        }

        // If dp[n] is still n + 1, it means the target string cannot be formed
        if dp[n] > n {
            -1
        } else {
            // Otherwise, dp[n] contains the minimum number of words
            dp[n] as i32
        }
    }
}