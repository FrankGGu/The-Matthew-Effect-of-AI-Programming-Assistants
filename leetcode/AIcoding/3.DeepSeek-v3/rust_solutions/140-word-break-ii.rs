use std::collections::HashSet;

impl Solution {
    pub fn word_break(s: String, word_dict: Vec<String>) -> Vec<String> {
        let word_set: HashSet<String> = word_dict.into_iter().collect();
        let mut memo = std::collections::HashMap::new();
        Self::dfs(&s, &word_set, &mut memo)
    }

    fn dfs(s: &str, word_set: &HashSet<String>, memo: &mut std::collections::HashMap<String, Vec<String>>) -> Vec<String> {
        if let Some(result) = memo.get(s) {
            return result.clone();
        }

        let mut res = Vec::new();
        if s.is_empty() {
            res.push("".to_string());
            return res;
        }

        for i in 1..=s.len() {
            let word = &s[..i];
            if word_set.contains(word) {
                let sub_res = Self::dfs(&s[i..], word_set, memo);
                for sub in sub_res {
                    if sub.is_empty() {
                        res.push(word.to_string());
                    } else {
                        res.push(format!("{} {}", word, sub));
                    }
                }
            }
        }

        memo.insert(s.to_string(), res.clone());
        res
    }
}