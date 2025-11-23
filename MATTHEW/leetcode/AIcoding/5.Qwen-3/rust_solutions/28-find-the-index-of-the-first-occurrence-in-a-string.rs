struct Solution;

impl Solution {
    pub fn str_str(haystack: String, needle: String) -> i32 {
        if needle.is_empty() {
            return 0;
        }
        if haystack.len() < needle.len() {
            return -1;
        }
        for i in 0..=haystack.len() - needle.len() {
            let mut match_found = true;
            for j in 0..needle.len() {
                if haystack.as_bytes()[i + j] != needle.as_bytes()[j] {
                    match_found = false;
                    break;
                }
            }
            if match_found {
                return i as i32;
            }
        }
        -1
    }
}