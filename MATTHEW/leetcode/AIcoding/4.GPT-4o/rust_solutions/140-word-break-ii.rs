use std::collections::HashMap;

impl Solution {
    pub fn word_break(s: String, word_dict: Vec<String>) -> Vec<String> {
        let dict: std::collections::HashSet<String> = word_dict.into_iter().collect();
        let mut memo: HashMap<String, Vec<String>> = HashMap::new();
        Self::backtrack(&s, &dict, &mut memo);
        memo.get(&s).cloned().unwrap_or_default()
    }

    fn backtrack(s: &str, dict: &std::collections::HashSet<String>, memo: &mut HashMap<String, Vec<String>>) -> Vec<String> {
        if let Some(res) = memo.get(s) {
            return res.clone();
        }
        if s.is_empty() {
            return vec!["".to_string()];
        }

        let mut res = Vec::new();
        for i in 1..=s.len() {
            let word = &s[..i];
            if dict.contains(word) {
                let suffix = &s[i..];
                for sub in Self::backtrack(suffix, dict, memo) {
                    let sentence = if sub.is_empty() {
                        word.to_string()
                    } else {
                        format!("{} {}", word, sub)
                    };
                    res.push(sentence);
                }
            }
        }
        memo.insert(s.to_string(), res.clone());
        res
    }
}