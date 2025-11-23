impl Solution {

use std::collections::HashMap;

struct Encrypter {
    key_map: HashMap<char, Vec<char>>,
    reverse_map: HashMap<char, char>,
}

impl Encrypter {
    fn new(keys: Vec<char>, values: Vec<String>) -> Self {
        let mut key_map = HashMap::new();
        let mut reverse_map = HashMap::new();

        for (i, &key) in keys.iter().enumerate() {
            let value = &values[i];
            key_map.insert(key, value.chars().collect());
            for c in value.chars() {
                reverse_map.insert(c, key);
            }
        }

        Encrypter { key_map, reverse_map }
    }

    fn encrypt(&self, s: String) -> String {
        s.chars()
            .map(|c| self.key_map.get(&c).cloned().unwrap_or_default())
            .flatten()
            .collect()
    }

    fn decrypt(&self, s: String) -> i32 {
        let mut count = 0;
        let mut i = 0;
        while i < s.len() {
            let c = s.chars().nth(i).unwrap();
            if let Some(&key) = self.reverse_map.get(&c) {
                count += 1;
                i += 1;
            } else {
                return -1;
            }
        }
        count
    }
}

pub fn solve() {
    let keys = vec!['a', 'b', 'c'];
    let values = vec![
        "x".to_string(),
        "y".to_string(),
        "z".to_string(),
    ];
    let encrypter = Encrypter::new(keys, values);

    let encrypted = encrypter.encrypt("abc".to_string());
    let decrypted = encrypter.decrypt(encrypted);

    println!("{}", decrypted);
}
}