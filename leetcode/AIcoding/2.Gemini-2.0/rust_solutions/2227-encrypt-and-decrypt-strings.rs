use std::collections::HashMap;

struct Encrypter {
    keys: Vec<char>,
    values: Vec<String>,
    dictionary: Vec<String>,
    encryption_map: HashMap<char, String>,
}

impl Encrypter {
    fn new(keys: Vec<char>, values: Vec<String>, dictionary: Vec<String>) -> Self {
        let mut encryption_map = HashMap::new();
        for i in 0..keys.len() {
            encryption_map.insert(keys[i], values[i].clone());
        }
        Encrypter {
            keys,
            values,
            dictionary,
            encryption_map,
        }
    }

    fn encrypt(&self, word1: String) -> String {
        let mut encrypted_word = String::new();
        for c in word1.chars() {
            if let Some(encrypted_char) = self.encryption_map.get(&c) {
                encrypted_word.push_str(encrypted_char);
            } else {
                return String::new();
            }
        }
        encrypted_word
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