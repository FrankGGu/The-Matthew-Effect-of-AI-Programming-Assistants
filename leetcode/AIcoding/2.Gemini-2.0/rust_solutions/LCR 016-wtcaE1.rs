use std::collections::HashSet;

impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut start = 0;
        let mut end = 0;
        let mut char_set: HashSet<char> = HashSet::new();
        let chars: Vec<char> = s.chars().collect();

        while end < chars.len() {
            if !char_set.contains(&chars[end]) {
                char_set.insert(chars[end]);
                end += 1;
                max_len = std::cmp::max(max_len, char_set.len() as i32);
            } else {
                char_set.remove(&chars[start]);
                start += 1;
            }
        }

        max_len
    }
}