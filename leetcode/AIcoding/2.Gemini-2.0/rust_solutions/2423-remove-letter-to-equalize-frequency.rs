use std::collections::HashMap;

impl Solution {
    pub fn equal_frequency(word: String) -> bool {
        let mut counts: HashMap<char, i32> = HashMap::new();
        for c in word.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        for &c in &counts.keys().collect::<Vec<_>>() {
            let mut new_counts: HashMap<char, i32> = counts.clone();
            *new_counts.get_mut(&c).unwrap() -= 1;
            if new_counts[&c] == 0 {
                new_counts.remove(&c);
            }

            if new_counts.is_empty() {
                return true;
            }

            let mut frequencies: HashMap<i32, i32> = HashMap::new();
            for &count in new_counts.values() {
                *frequencies.entry(count).or_insert(0) += 1;
            }

            if frequencies.len() == 1 {
                return true;
            }
        }

        false
    }
}