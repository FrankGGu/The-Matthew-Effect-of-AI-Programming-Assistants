impl Solution {
    pub fn max_length_between_equal_characters(s: String) -> i32 {
        let mut indices = std::collections::HashMap::new();
        let mut max_length = -1;

        for (i, c) in s.chars().enumerate() {
            if let Some(&first_index) = indices.get(&c) {
                max_length = max_length.max(i as i32 - first_index as i32 - 1);
            } else {
                indices.insert(c, i);
            }
        }

        max_length
    }
}