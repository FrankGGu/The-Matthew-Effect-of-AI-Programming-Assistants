impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut char_index = std::collections::HashMap::new();
        let mut max_length = 0;
        let (mut start, n) = (0, s.len());

        for (i, c) in s.chars().enumerate() {
            if let Some(&last_index) = char_index.get(&c) {
                start = start.max(last_index + 1);
            }
            char_index.insert(c, i);
            max_length = max_length.max(i - start + 1);
        }

        max_length as i32
    }
}