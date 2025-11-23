use std::collections::HashMap;
use std::collections::HashSet;

impl Solution {
    pub fn equal_frequency(word: String) -> bool {
        let mut char_counts: HashMap<char, i32> = HashMap::new();
        for c in word.chars() {
            *char_counts.entry(c).or_insert(0) += 1;
        }

        for c_to_remove in char_counts.keys().cloned().collect::<Vec<char>>() {
            let mut temp_counts = char_counts.clone();

            *temp_counts.get_mut(&c_to_remove).unwrap() -= 1;

            let mut non_zero_frequencies = HashSet::new();
            for &count in temp_counts.values() {
                if count > 0 {
                    non_zero_frequencies.insert(count);
                }
            }

            if non_zero_frequencies.len() <= 1 {
                return true;
            }
        }

        false
    }
}