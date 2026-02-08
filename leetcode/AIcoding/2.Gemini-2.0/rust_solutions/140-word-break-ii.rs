impl Solution {
    pub fn word_break(s: String, word_dict: Vec<String>) -> Vec<String> {
        let word_set: std::collections::HashSet<String> = word_dict.into_iter().collect();
        let mut memo: std::collections::HashMap<String, Vec<String>> = std::collections::HashMap::new();

        fn dfs(s: String, word_set: &std::collections::HashSet<String>, memo: &mut std::collections::HashMap<String, Vec<String>>) -> Vec<String> {
            if memo.contains_key(&s) {
                return memo.get(&s).unwrap().clone();
            }

            if s.is_empty() {
                return vec![String::new()];
            }

            let mut result: Vec<String> = Vec::new();
            for i in 1..=s.len() {
                let prefix = &s[0..i];
                if word_set.contains(prefix) {
                    let suffix = &s[i..];
                    let suffix_results = dfs(suffix.to_string(), word_set, memo);
                    for suffix_result in suffix_results {
                        if suffix_result.is_empty() {
                            result.push(prefix.to_string());
                        } else {
                            result.push(format!("{} {}", prefix, suffix_result));
                        }
                    }
                }
            }

            memo.insert(s.clone(), result.clone());
            result
        }

        let result = dfs(s, &word_set, &mut memo);
        result
    }
}