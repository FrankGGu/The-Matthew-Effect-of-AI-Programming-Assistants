use std::collections::HashMap;

impl Solution {
    pub fn last_non_empty_string(s: String) -> String {
        let mut freq = HashMap::new();
        let mut last_occurrence = HashMap::new();
        let chars: Vec<char> = s.chars().collect();

        for (i, &c) in chars.iter().enumerate() {
            *freq.entry(c).or_insert(0) += 1;
            last_occurrence.insert(c, i);
        }

        let max_freq = *freq.values().max().unwrap();
        let mut candidates: Vec<(usize, char)> = freq
            .iter()
            .filter(|&(_, &count)| count == max_freq)
            .map(|(&c, _)| (last_occurrence[&c], c))
            .collect();

        candidates.sort();
        candidates.into_iter().map(|(_, c)| c).collect()
    }
}