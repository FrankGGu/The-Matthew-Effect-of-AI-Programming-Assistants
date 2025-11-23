impl Solution {
    pub fn spellchecker(wordlist: Vec<String>, queries: Vec<String>) -> Vec<String> {
        use std::collections::HashSet;
        use std::collections::HashMap;

        let mut perfect: HashSet<String> = HashSet::new();
        let mut cap: HashMap<String, String> = HashMap::new();
        let mut vowel: HashMap<String, String> = HashMap::new();

        for word in &wordlist {
            perfect.insert(word.clone());

            let lower = word.to_lowercase();
            if !cap.contains_key(&lower) {
                cap.insert(lower.clone(), word.clone());
            }

            let devowel = lower.chars().map(|c| match c {
                'a' | 'e' | 'i' | 'o' | 'u' => '*',
                _ => c,
            }).collect::<String>();

            if !vowel.contains_key(&devowel) {
                vowel.insert(devowel.clone(), word.clone());
            }
        }

        let mut result: Vec<String> = Vec::new();
        for query in &queries {
            if perfect.contains(query) {
                result.push(query.clone());
            } else {
                let lower = query.to_lowercase();
                if cap.contains_key(&lower) {
                    result.push(cap[&lower].clone());
                } else {
                    let devowel = lower.chars().map(|c| match c {
                        'a' | 'e' | 'i' | 'o' | 'u' => '*',
                        _ => c,
                    }).collect::<String>();
                    if vowel.contains_key(&devowel) {
                        result.push(vowel[&devowel].clone());
                    } else {
                        result.push("".to_string());
                    }
                }
            }
        }

        result
    }
}