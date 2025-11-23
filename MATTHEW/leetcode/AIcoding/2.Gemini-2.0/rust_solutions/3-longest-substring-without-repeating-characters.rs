use std::collections::HashSet;

impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut start = 0;
        let mut end = 0;
        let mut seen: HashSet<char> = HashSet::new();

        let chars: Vec<char> = s.chars().collect();

        while end < chars.len() {
            if !seen.contains(&chars[end]) {
                seen.insert(chars[end]);
                end += 1;
                max_len = std::cmp::max(max_len, (end - start) as i32);
            } else {
                seen.remove(&chars[start]);
                start += 1;
            }
        }

        max_len
    }
}