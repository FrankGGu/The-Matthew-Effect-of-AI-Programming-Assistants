use std::collections::{HashSet, HashMap};

impl Solution {
    fn normalize_vowels(s: &str) -> String {
        let mut result = String::with_capacity(s.len());
        for c in s.chars() {
            let lower_c = c.to_ascii_lowercase();
            match lower_c {
                'a' | 'e' | 'i' | 'o' | 'u' => result.push('*'),
                _ => result.push(lower_c),
            }
        }
        result
    }

    pub fn vowel_spellchecker(wordlist: Vec<String>, queries: Vec<String>) -> Vec<String> {
        let mut exact_words: HashSet<String> = HashSet::new();
        let mut case_insensitive_map: HashMap<String, String> = HashMap::new();
        let mut vowel_normalized_map: HashMap<String, String> = HashMap::new();

        for word in wordlist {
            exact_words.insert(word.clone());

            let lower_word = word.to_ascii_lowercase();
            case_insensitive_map.entry(lower_word).or_insert(word.clone());

            let vowel_normalized_word = Self::normalize_vowels(&word);
            vowel_normalized_map.entry(vowel_normalized_word).or_insert(word);
        }

        let mut results: Vec<String> = Vec::with_capacity(queries.len());

        for query in queries {
            if exact_words.contains(&query) {
                results.push(query);
                continue;
            }

            let lower_query = query.to_ascii_lowercase();
            if let Some(original_word) = case_insensitive_map.get(&lower_query) {
                results.push(original_word.clone());
                continue;
            }

            let vowel_normalized_query = Self::normalize_vowels(&query);
            if let Some(original_word) = vowel_normalized_map.get(&vowel_normalized_query) {
                results.push(original_word.clone());
                continue;
            }

            results.push("".to_string());
        }

        results
    }
}