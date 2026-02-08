use std::collections::HashMap;

struct WordFilter {
    map: HashMap<String, i32>,
}

impl WordFilter {
    fn new(words: Vec<String>) -> Self {
        let mut map: HashMap<String, i32> = HashMap::new();
        for (i, word) in words.into_iter().enumerate() {
            let n = word.len();
            for p_len in 0..=n {
                let prefix = &word[0..p_len];
                for s_len in 0..=n {
                    let suffix = &word[n - s_len..n];
                    let key = format!("{}#{}", prefix, suffix);
                    map.insert(key, i as i32);
                }
            }
        }
        WordFilter { map }
    }

    fn f(&self, pref: String, suff: String) -> i32 {
        let key = format!("{}#{}", pref, suff);
        *self.map.get(&key).unwrap_or(&-1)
    }
}