use std::collections::HashSet;

impl Solution {
    pub fn longest_nice_substring(s: String) -> String {
        Self::solve_recursive(s.as_bytes())
    }

    fn solve_recursive(s_bytes: &[u8]) -> String {
        if s_bytes.len() < 2 {
            return String::new();
        }

        let mut chars_present = HashSet::new();
        for &b in s_bytes {
            chars_present.insert(b);
        }

        for i in 0..s_bytes.len() {
            let c = s_bytes[i];

            // A character 'c' is a breaking character if its opposite case is not present
            // in the entire substring 's_bytes'.
            // For example, if 'c' is 'a', but 'A' is not in chars_present, then 'a' is a breaker.
            // If 'c' is 'A', but 'a' is not in chars_present, then 'A' is a breaker.
            if !chars_present.contains(&c.to_ascii_lowercase()) || !chars_present.contains(&c.to_ascii_uppercase()) {
                // 'c' is a breaking character. Split the string into two parts.
                let left_res = Self::solve_recursive(&s_bytes[0..i]);
                let right_res = Self::solve_recursive(&s_bytes[i+1..]);

                // Return the longer of the two results.
                // If lengths are equal, prioritize the left one (earliest occurrence).
                if left_res.len() >= right_res.len() {
                    return left_res;
                } else {
                    return right_res;
                }
            }
        }

        // If no breaking character was found, the entire string 's_bytes' is nice.
        String::from_utf8(s_bytes.to_vec()).unwrap()
    }
}