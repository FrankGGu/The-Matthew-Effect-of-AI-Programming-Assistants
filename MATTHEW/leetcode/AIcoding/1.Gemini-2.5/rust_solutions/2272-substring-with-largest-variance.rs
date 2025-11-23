use std::cmp::max;

impl Solution {
    pub fn largest_variance(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let mut max_variance = 0;

        // Iterate through all possible pairs of distinct characters (char_a, char_b)
        // There are 26 * 25 such pairs.
        for i in 0..26 {
            for j in 0..26 {
                if i == j {
                    continue; // Characters must be distinct
                }

                let char_a = (b'a' + i) as char;
                let char_b = (b'a' + j) as char;

                // current_max_diff: Tracks freq(char_a) - freq(char_b) for the current window.
                // This behaves like a standard Kadane's algorithm, resetting if the sum goes negative.
                // It ensures that char_a is always "dominant" or at least equal to char_b in terms of frequency difference.
                let mut current_max_diff = 0;

                // current_max_diff_minus_one_b: Tracks freq(char_a) - (freq(char_b) - 1).
                // This variable is crucial. It effectively allows "skipping" one instance of char_b
                // to maximize the variance. By skipping one char_b, we guarantee that at least one
                // char_b must have been encountered in the current substring for this value to be meaningful.
                // Initialize to a very small number to ensure it's only considered after a char_b is truly "skipped" or counted.
                let mut current_max_diff_minus_one_b = -s.len() as i32 - 1; 

                for &c in chars.iter() {
                    if c == char_a {
                        current_max_diff += 1;
                        current_max_diff_minus_one_b += 1;
                    } else if c == char_b {
                        // When char_b is encountered:
                        // Update current_max_diff_minus_one_b:
                        // Option 1: Start a new `_minus_one_b` sequence. This is done by taking the current `current_max_diff`
                        //           and effectively 'skipping' the current `char_b` (hence `current_max_diff - 1`).
                        // Option 2: Continue the existing `_minus_one_b` sequence by decrementing it.
                        current_max_diff_minus_one_b = max(current_max_diff - 1, current_max_diff_minus_one_b - 1);
                        current_max_diff -= 1;
                    }

                    // Update the overall maximum variance.
                    // `current_max_diff_minus_one_b` represents a valid variance because it implies
                    // that at least one `char_b` has been present (the one that was effectively 'skipped' or counted as part of the -1).
                    max_variance = max(max_variance, current_max_diff_minus_one_b);

                    // Kadane's reset logic for current_max_diff:
                    // If current_max_diff becomes negative, it means char_b is dominating.
                    // Reset it to 0 to start a new window where char_a might dominate.
                    // This ensures current_max_diff always represents a potential positive contribution from char_a.
                    if current_max_diff < 0 {
                        current_max_diff = 0;
                    }
                }
            }
        }

        max_variance
    }
}