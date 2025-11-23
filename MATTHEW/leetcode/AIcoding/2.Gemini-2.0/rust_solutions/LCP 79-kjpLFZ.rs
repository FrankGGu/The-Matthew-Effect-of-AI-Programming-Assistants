impl Solution {
    pub fn spellchecker(wordlist: Vec<String>, queries: Vec<String>) -> Vec<String> {
        use std::collections::{HashMap, HashSet};

        let perfect: HashSet<String> = wordlist.iter().cloned().collect();
        let mut vowel: HashMap<String, String> = HashMap::new();
        let mut cap: HashMap<String, String> = HashMap::new();

        for word in wordlist {
            let lower = word.to_lowercase();
            if !cap.contains_key(&lower) {
                cap.insert(lower.clone(), word.clone());
            }

            let vowel_removed = lower
                .chars()
                .map(|c| match c {
                    'a' | 'e' | 'i' | 'o' | 'u' => '*',
                    _ => c,
                })
                .collect::<String>();

            if !vowel.contains_key(&vowel_removed) {
                vowel.insert(vowel_removed, word);
            }
        }

        let mut result = Vec::new();
        for query in queries {
            if perfect.contains(&query) {
                result.push(query);
                continue;
            }

            let lower = query.to_lowercase();
            if let Some(word) = cap.get(&lower) {
                result.push(word.clone());
                continue;
            }

            let vowel_removed = lower
                .chars()
                .map(|c| match c {
                    'a' | 'e' | 'i' | 'o' | 'u' => '*',
                    _ => c,
                })
                .collect::<String>();

            if let Some(word) = vowel.get(&vowel_removed) {
                result.push(word.clone());
                continue;
            }

            result.push("".to_string());
        }

        result
    }
}