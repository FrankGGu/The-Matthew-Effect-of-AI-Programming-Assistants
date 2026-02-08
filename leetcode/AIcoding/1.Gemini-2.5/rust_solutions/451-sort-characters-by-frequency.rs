use std::collections::HashMap;

impl Solution {
    pub fn frequency_sort(s: String) -> String {
        let mut freq_map: HashMap<char, i32> = HashMap::new();
        for c in s.chars() {
            *freq_map.entry(c).or_insert(0) += 1;
        }

        let mut freq_vec: Vec<(char, i32)> = freq_map.into_iter().collect();

        freq_vec.sort_by(|a, b| b.1.cmp(&a.1));

        let mut result = String::new();
        for (c, count) in freq_vec {
            for _ in 0..count {
                result.push(c);
            }
        }

        result
    }
}