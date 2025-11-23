use std::collections::HashMap;

struct WordFilter {
    map: HashMap<String, i32>,
}

impl WordFilter {
    fn new(words: Vec<String>) -> Self {
        let mut map = HashMap::new();
        let n = words.len();

        for (i, word) in words.iter().enumerate() {
            let mut prefix = String::new();
            for c in word.chars() {
                prefix.push(c);
                let key = format!("{}#{}", prefix, word);
                map.insert(key, i as i32);
            }
        }

        WordFilter { map }
    }

    fn f(&self, prefix: String, suffix: String) -> i32 {
        let key = format!("{}#{}", prefix, suffix);
        *self.map.get(&key).unwrap_or(&-1)
    }
}