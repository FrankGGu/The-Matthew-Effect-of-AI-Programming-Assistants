impl Solution {
    pub fn first_uniq_char(s: String) -> i32 {
        use std::collections::HashMap;

        let mut char_counts: HashMap<char, i32> = HashMap::new();

        for c in s.chars() {
            *char_counts.entry(c).or_insert(0) += 1;
        }

        for (i, c) in s.chars().enumerate() {
            if char_counts.get(&c) == Some(&1) {
                return i as i32;
            }
        }

        -1
    }
}