use std::collections::HashMap;

struct Encrypter {
    key_to_val: HashMap<char, String>,
    dictionary: Vec<String>,
}

impl Encrypter {
    fn new(keys: Vec<char>, values: Vec<String>, dictionary: Vec<String>) -> Self {
        let key_to_val: HashMap<char, String> = keys
            .into_iter()
            .zip(values.into_iter())
            .collect();
        Encrypter {
            key_to_val,
            dictionary,
        }
    }

    fn encrypt(&self, word1: String) -> String {
        let mut res = String::new();
        for c in word1.chars() {
            if let Some(s) = self.key_to_val.get(&c) {
                res.push_str(s);
            } else {
                return String::new();
            }
        }
        res
    }

    fn decrypt(&self, word2: String) -> i32 {
        let mut count = 0;
        for word in &self.dictionary {
            if self.encrypt(word.clone()) == word2 {
                count += 1;
            }
        }
        count
    }
}