use std::collections::HashMap;

struct Encrypter {
    key_to_value_map: HashMap<char, String>,
    encrypted_dictionary_counts: HashMap<String, i32>,
}

impl Encrypter {
    fn new(keys: Vec<char>, values: Vec<String>, dictionary: Vec<String>) -> Self {
        let mut key_to_value_map = HashMap::new();
        for (key, value) in keys.into_iter().zip(values.into_iter()) {
            key_to_value_map.insert(key, value);
        }

        let mut encrypter_instance = Encrypter {
            key_to_value_map,
            encrypted_dictionary_counts: HashMap::new(),
        };

        for dict_word in dictionary {
            let encrypted_word = encrypter_instance.encrypt(dict_word);
            *encrypter_instance.encrypted_dictionary_counts.entry(encrypted_word).or_insert(0) += 1;
        }

        encrypter_instance
    }

    fn encrypt(&self, word1: String) -> String {
        let mut result = String::new();
        for c in word1.chars() {
            result.push_str(self.key_to_value_map.get(&c).unwrap());
        }
        result
    }

    fn decrypt(&self, word2: String) -> i32 {
        *self.encrypted_dictionary_counts.get(&word2).unwrap_or(&0)
    }
}