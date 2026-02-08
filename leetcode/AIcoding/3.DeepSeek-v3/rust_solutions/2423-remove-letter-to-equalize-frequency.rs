use std::collections::HashMap;

impl Solution {
    pub fn equal_frequency(word: String) -> bool {
        let mut freq = HashMap::new();
        for c in word.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort();

        if counts.len() == 1 {
            return true;
        }

        let first = counts[0];
        let last = *counts.last().unwrap();
        let all_same_first = counts.iter().all(|&x| x == first);
        let all_same_last = counts.iter().all(|&x| x == last);

        if counts.len() == 2 {
            return first == 1 || last - first == 1;
        }

        if all_same_first && first == 1 {
            return true;
        }

        if counts[0] == counts[counts.len() - 2] && last - counts[0] == 1 {
            return true;
        }

        false
    }
}