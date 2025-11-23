impl Solution {
    pub fn minimum_deletions(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        // b_count_left: number of 'b's encountered so far in the prefix (which should ideally be all 'a's)
        let mut b_count_left = 0;
        // a_count_right: number of 'a's remaining in the suffix (which should ideally be all 'b's)
        let mut a_count_right = 0;

        // Calculate initial a_count_right (total 'a's in the string)
        for c in s.chars() {
            if c == 'a' {
                a_count_right += 1;
            }
        }

        // Initialize min_deletions.
        // This initial value corresponds to the case where the split point is at index 0.
        // This means the entire string should be 'b's. So, delete all 'a's.
        // The cost is a_count_right (all 'a's in the original string).
        let mut min_deletions = a_count_right;

        // Iterate through all possible split points in the string.
        // The loop considers the split point *after* the current character `s_char`.
        for s_char in s.chars() {
            if s_char == 'a' {
                // If the current character is 'a', it means it was part of the 'a_count_right'
                // (suffix that should be 'b's). Now that it's moved to the prefix part (which
                // should be 'a's), it no longer needs to be deleted from the suffix.
                a_count_right -= 1;
            } else { // s_char == 'b'
                // If the current character is 'b', it means it's now part of the 'b_count_left'
                // (prefix that should be 'a's). This 'b' must be deleted.
                b_count_left += 1;
            }

            // After processing s_char, we consider the split point *after* s_char.
            // The number of deletions for this split is:
            // (number of 'b's in the prefix up to and including s_char)
            // + (number of 'a's in the suffix starting from the character after s_char)
            min_deletions = min_deletions.min(b_count_left + a_count_right);
        }

        min_deletions
    }
}