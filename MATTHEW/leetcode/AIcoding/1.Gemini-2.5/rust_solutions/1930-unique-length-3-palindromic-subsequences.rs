use std::collections::HashSet;

impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let mut ans = 0;

        for i in 0..26 {
            let c_outer = (b'a' + i) as char;

            let first_idx = s.find(c_outer);
            let last_idx = s.rfind(c_outer);

            if let (Some(f_idx), Some(l_idx)) = (first_idx, last_idx) {
                if f_idx < l_idx {
                    let mut unique_middle_chars = HashSet::new();

                    // Get the slice of the string between the first and last occurrences of c_outer
                    // If f_idx + 1 >= l_idx, this slice will be empty or invalid,
                    // and s.get() will return None or an empty slice, which is handled correctly.
                    if let Some(middle_slice) = s.get(f_idx + 1..l_idx) {
                        for c in middle_slice.chars() {
                            unique_middle_chars.insert(c);
                        }
                    }
                    ans += unique_middle_chars.len();
                }
            }
        }
        ans as i32
    }
}