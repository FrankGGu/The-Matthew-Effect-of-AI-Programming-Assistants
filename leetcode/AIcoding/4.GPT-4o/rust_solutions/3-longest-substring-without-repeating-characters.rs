impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut char_map = std::collections::HashMap::new();
        let (mut left, mut max_len) = (0, 0);

        for (right, char) in s.chars().enumerate() {
            if let Some(&index) = char_map.get(&char) {
                left = left.max(index + 1);
            }
            char_map.insert(char, right);
            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}