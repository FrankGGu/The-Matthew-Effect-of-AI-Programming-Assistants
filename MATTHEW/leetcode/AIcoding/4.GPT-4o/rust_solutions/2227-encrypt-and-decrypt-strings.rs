struct Encrypter {
    key: Vec<char>,
    map: std::collections::HashMap<char, String>,
    rev_map: std::collections::HashMap<String, char>,
}

impl Encrypter {
    fn new(keys: Vec<char>, values: Vec<String>) -> Self {
        let mut map = std::collections::HashMap::new();
        let mut rev_map = std::collections::HashMap::new();
        for (i, &k) in keys.iter().enumerate() {
            map.insert(k, values[i].clone());
            rev_map.insert(values[i].clone(), k);
        }
        Encrypter { key: keys, map, rev_map }
    }

    fn encrypt(&self, text: String) -> String {
        let mut result = String::new();
        for ch in text.chars() {
            if let Some(enc) = self.map.get(&ch) {
                result.push_str(enc);
            } else {
                return String::new();
            }
        }
        result
    }

    fn decrypt(&self, code: String) -> String {
        if code.len() % 2 != 0 {
            return String::new();
        }
        let mut result = String::new();
        let mut i = 0;
        while i < code.len() {
            let part = &code[i..i + 2];
            if let Some(&dec) = self.rev_map.get(part) {
                result.push(dec);
            } else {
                return String::new();
            }
            i += 2;
        }
        result
    }
}