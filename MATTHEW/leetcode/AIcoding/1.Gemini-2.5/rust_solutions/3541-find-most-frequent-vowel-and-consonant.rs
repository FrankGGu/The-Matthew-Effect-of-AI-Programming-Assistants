use std::collections::HashMap;

impl Solution {
    pub fn find_most_frequent_vowel_and_consonant(s: String) -> (char, char) {
        let vowels_set: [char; 5] = ['a', 'e', 'i', 'o', 'u'];
        let mut vowel_counts: HashMap<char, i32> = HashMap::new();
        let mut consonant_counts: HashMap<char, i32> = HashMap::new();

        for c in s.chars() {
            let c_lower = c.to_ascii_lowercase();
            if c_lower.is_ascii_alphabetic() {
                if vowels_set.contains(&c_lower) {
                    *vowel_counts.entry(c_lower).or_insert(0) += 1;
                } else {
                    *consonant_counts.entry(c_lower).or_insert(0) += 1;
                }
            }
        }

        let mut most_frequent_vowel = ' ';
        let mut max_vowel_count = 0;

        let mut sorted_vowels: Vec<char> = vowel_counts.keys().cloned().collect();
        sorted_vowels.sort_unstable();

        for &vowel in sorted_vowels.iter() {
            let count = *vowel_counts.get(&vowel).unwrap();
            if count > max_vowel_count {
                max_vowel_count = count;
                most_frequent_vowel = vowel;
            }
        }

        let mut most_frequent_consonant = ' ';
        let mut max_consonant_count = 0;

        let mut sorted_consonants: Vec<char> = consonant_counts.keys().cloned().collect();
        sorted_consonants.sort_unstable();

        for &consonant in sorted_consonants.iter() {
            let count = *consonant_counts.get(&consonant).unwrap();
            if count > max_consonant_count {
                max_consonant_count = count;
                most_frequent_consonant = consonant;
            }
        }

        (most_frequent_vowel, most_frequent_consonant)
    }
}