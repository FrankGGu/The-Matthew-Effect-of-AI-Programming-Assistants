impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let m = s_chars.len();
        let n = t_chars.len();
        let mut count = 0;

        for i in 0..m { // starting index for substring in s
            for j in 0..n { // starting index for substring in t
                let mut diff = 0;
                // Iterate through possible lengths for substrings starting at (i, j)
                // k_offset represents the current character's offset from the start of the substring
                for k_offset in 0..std::cmp::min(m - i, n - j) {
                    if s_chars[i + k_offset] != t_chars[j + k_offset] {
                        diff += 1;
                    }

                    // If the current substrings (of length k_offset + 1) differ by exactly one character,
                    // increment the total count.
                    if diff == 1 {
                        count += 1;
                    } 
                    // If the current substrings differ by more than one character,
                    // any longer substrings starting at (i, j) will also differ by more than one.
                    // So, we can stop extending for this pair of starting indices (i, j).
                    else if diff > 1 {
                        break;
                    }
                }
            }
        }
        count
    }
}