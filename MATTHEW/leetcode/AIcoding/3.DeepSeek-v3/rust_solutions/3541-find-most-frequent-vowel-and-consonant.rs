use std::collections::HashMap;

impl Solution {
    pub fn find_most_frequent_vowel_and_consonant(s: String) -> Vec<char> {
        let vowels: Vec<char> = vec!['a', 'e', 'i', 'o', 'u'];
        let mut vowel_counts = HashMap::new();
        let mut consonant_counts = HashMap::new();

        for c in s.chars().filter(|c| c.is_alphabetic()) {
            let lower_c = c.to_ascii_lowercase();
            if vowels.contains(&lower_c) {
                *vowel_counts.entry(lower_c).or_insert(0) += 1;
            } else {
                *consonant_counts.entry(lower_c).or_insert(0) += 1;
            }
        }

        let most_frequent_vowel = vowel_counts.iter()
            .max_by_key(|&(_, count)| count)
            .map(|(&c, _)| c)
            .unwrap_or('0');

        let most_frequent_consonant = consonant_counts.iter()
            .max_by_key(|&(_, count)| count)
            .map(|(&c, _)| c)
            .unwrap_or('0');

        vec![most_frequent_vowel, most_frequent_consonant]
    }
}