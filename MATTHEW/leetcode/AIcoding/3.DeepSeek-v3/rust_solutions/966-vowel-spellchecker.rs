use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn spellchecker(wordlist: Vec<String>, queries: Vec<String>) -> Vec<String> {
        let mut exact_match = HashSet::new();
        let mut case_insensitive = HashMap::new();
        let mut vowel_insensitive = HashMap::new();

        for word in wordlist.iter() {
            exact_match.insert(word.clone());

            let lower_word = word.to_lowercase();
            case_insensitive.entry(lower_word.clone()).or_insert(word.clone());

            let devoweled = lower_word.chars().map(|c| 
                match c {
                    'a' | 'e' | 'i' | 'o' | 'u' => '*',
                    _ => c
                }
            ).collect::<String>();
            vowel_insensitive.entry(devoweled).or_insert(word.clone());
        }

        queries.into_iter().map(|query| {
            if exact_match.contains(&query) {
                return query;
            }

            let lower_query = query.to_lowercase();
            if let Some(word) = case_insensitive.get(&lower_query) {
                return word.clone();
            }

            let devoweled_query = lower_query.chars().map(|c| 
                match c {
                    'a' | 'e' | 'i' | 'o' | 'u' => '*',
                    _ => c
                }
            ).collect::<String>();
            if let Some(word) = vowel_insensitive.get(&devoweled_query) {
                return word.clone();
            }

            String::new()
        }).collect()
    }
}