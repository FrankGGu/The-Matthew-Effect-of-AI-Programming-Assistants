use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_vowel_and_consonant(s: String) -> Vec<String> {
        let mut vowel_counts: HashMap<char, i32> = HashMap::new();
        let mut consonant_counts: HashMap<char, i32> = HashMap::new();

        for c in s.to_lowercase().chars() {
            if c.is_alphabetic() {
                if "aeiou".contains(c) {
                    *vowel_counts.entry(c).or_insert(0) += 1;
                } else {
                    *consonant_counts.entry(c).or_insert(0) += 1;
                }
            }
        }

        let mut max_vowel = None;
        let mut max_vowel_count = 0;

        for (vowel, count) in &vowel_counts {
            if *count > max_vowel_count {
                max_vowel = Some(*vowel);
                max_vowel_count = *count;
            }
        }

        let mut max_consonant = None;
        let mut max_consonant_count = 0;

        for (consonant, count) in &consonant_counts {
            if *count > max_consonant_count {
                max_consonant = Some(*consonant);
                max_consonant_count = *count;
            }
        }

        let mut result: Vec<String> = Vec::new();

        if let Some(vowel) = max_vowel {
            result.push(vowel.to_string());
        }

        if let Some(consonant) = max_consonant {
            result.push(consonant.to_string());
        }

        result
    }
}