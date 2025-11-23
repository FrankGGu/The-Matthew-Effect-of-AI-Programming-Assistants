use std::collections::HashMap;

struct WordFilter {
    prefix_suffix_map: HashMap<(String, String), i32>,
}

impl WordFilter {
    fn new(words: Vec<String>) -> Self {
        let mut prefix_suffix_map = HashMap::new();
        for (index, word) in words.iter().enumerate() {
            let n = word.len();
            for i in 0..=n {
                let prefix = word[..i].to_string();
                for j in 0..=n {
                    let suffix = word[j..].to_string();
                    prefix_suffix_map.insert((prefix.clone(), suffix.clone()), index as i32);
                }
            }
        }
        WordFilter { prefix_suffix_map }
    }

    fn f(&self, prefix: String, suffix: String) -> i32 {
        *self.prefix_suffix_map.get(&(prefix, suffix)).unwrap_or(&-1)
    }
}