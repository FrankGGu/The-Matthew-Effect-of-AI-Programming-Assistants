impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        if s.is_empty() {
            return "".to_string();
        }

        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut start = 0;
        let mut max_len = 0;

        for i in 0..n {
            // Odd length palindromes, centered at i
            let len1 = Self::expand_around_center(s_bytes, i, i);
            // Even length palindromes, centered between i and i+1
            let len2 = Self::expand_around_center(s_bytes, i, i + 1);

            let current_max_len = len1.max(len2);

            if current_max_len > max_len {
                max_len = current_max_len;
                // Calculate the starting index of the palindrome
                // For a palindrome of length `L` centered at `i` (odd) or `(i, i+1)` (even),
                // the start index is `i - (L - 1) / 2`.
                start = i - (max_len - 1) / 2;
            }
        }

        s[start..(start + max_len)].to_string()
    }

    // Helper function to expand around a center and return the length of the palindrome
    // `left` and `right` are the initial center indices (can be the same for odd length, or adjacent for even length)
    fn expand_around_center(s_bytes: &[u8], mut left: usize, mut right: usize) -> usize {
        let n = s_bytes.len();

        // Use `isize` for `left` to handle decrementing below 0 without underflow
        let mut l_isize = left as isize;
        let mut r_isize = right as isize;

        while l_isize >= 0 && r_isize < n as isize && s_bytes[l_isize as usize] == s_bytes[r_isize as usize] {
            l_isize -= 1;
            r_isize += 1;
        }

        // After the loop, `l_isize` is one position too far left, and `r_isize` is one position too far right.
        // The actual palindrome spans from `l_isize + 1` to `r_isize - 1`.
        // Its length is `(r_isize - 1) - (l_isize + 1) + 1 = r_isize - l_isize - 1`.
        (r_isize - l_isize - 1) as usize
    }
}