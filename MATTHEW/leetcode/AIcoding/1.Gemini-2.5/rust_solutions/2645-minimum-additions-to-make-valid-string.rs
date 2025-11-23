impl Solution {
    pub fn minimum_additions(word: String) -> i32 {
        let mut ans = 0;
        let mut current_char_idx = 0; // 0 for 'a', 1 for 'b', 2 for 'c'

        for c in word.chars() {
            let char_val = (c as u8 - b'a') as i32;

            if char_val == current_char_idx {
                // Character matches the expected one in the current "abc" sequence
                current_char_idx = (current_char_idx + 1) % 3;
            } else if char_val == (current_char_idx + 1) % 3 {
                // Character is the next one after the expected one (e.g., expecting 'a', got 'b')
                // We need to add the skipped character (e.g., 'a')
                ans += 1;
                current_char_idx = (current_char_idx + 2) % 3; // Now expecting the char after 'b' (i.e., 'c')
            } else { // char_val == (current_char_idx + 2) % 3
                // Character is two positions after the expected one (e.g., expecting 'a', got 'c')
                // We need to add the two skipped characters (e.g., 'a', 'b')
                ans += 2;
                current_char_idx = (current_char_idx + 3) % 3; // Now expecting the char after 'c' (i.e., 'a', completing the cycle)
            }
        }

        // After processing all characters, add remaining characters to complete the last cycle
        if current_char_idx != 0 {
            ans += (3 - current_char_idx);
        } else if word.is_empty() {
            // Special case for an empty string, it needs 3 additions to become "abc"
            ans = 3;
        }
        // If current_char_idx is 0 and word is not empty, it means the last character processed completed an "abc" block.
        // No further additions are needed for this block.

        ans
    }
}