impl Solution {
    pub fn can_make_subsequence(str1: String, str2: String) -> bool {
        let s1_chars: Vec<char> = str1.chars().collect();
        let s2_chars: Vec<char> = str2.chars().collect();

        let n = s1_chars.len();
        let m = s2_chars.len();

        if m == 0 {
            return true;
        }
        if n < m {
            return false;
        }

        let mut s2_ptr = 0;

        for s1_ptr in 0..n {
            if s2_ptr < m {
                // The problem states: "You can choose to cyclically increment any character in str1 any number of times."
                // This implies that any character str1[i] can be transformed into any other character ('a' through 'z').
                // For example, 'a' can become 'a' (0 increments), 'b' (1 increment), ..., 'z' (25 increments).
                // The same logic applies to any starting character.
                // Therefore, the specific character value of s1_chars[s1_ptr] does not matter for matching s2_chars[s2_ptr].
                // We only need to find a character in str1 at the correct position to match the current str2 character.
                s2_ptr += 1;
            } else {
                break;
            }
        }

        s2_ptr == m
    }
}