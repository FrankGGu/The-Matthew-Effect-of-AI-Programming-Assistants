use std::collections::HashMap;

pub fn most_frequent_vowel_and_consonant(s: String) -> Vec<String> {
    let vowels = "aeiou";
    let mut vowel_count = HashMap::new();
    let mut consonant_count = HashMap::new();

    for c in s.chars() {
        if c.is_alphabetic() {
            let lower_c = c.to_ascii_lowercase();
            if vowels.contains(lower_c) {
                *vowel_count.entry(lower_c).or_insert(0) += 1;
            } else {
                *consonant_count.entry(lower_c).or_insert(0) += 1;
            }
        }
    }

    let most_frequent_vowel = vowel_count.iter().max_by_key(|entry| entry.1).map(|(k, _)| k.to_string()).unwrap_or_default();
    let most_frequent_consonant = consonant_count.iter().max_by_key(|entry| entry.1).map(|(k, _)| k.to_string()).unwrap_or_default();

    vec![most_frequent_vowel, most_frequent_consonant]
}