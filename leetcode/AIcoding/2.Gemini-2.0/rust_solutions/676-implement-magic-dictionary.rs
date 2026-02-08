struct MagicDictionary {
    dict: Vec<String>,
}

impl MagicDictionary {
    fn new() -> Self {
        MagicDictionary { dict: Vec::new() }
    }

    fn build_dict(&mut self, dictionary: Vec<String>) {
        self.dict = dictionary;
    }

    fn search(&self, search_word: String) -> bool {
        for word in &self.dict {
            if word.len() == search_word.len() {
                let mut diff = 0;
                for (i, c) in word.chars().enumerate() {
                    if c != search_word.chars().nth(i).unwrap() {
                        diff += 1;
                    }
                }
                if diff == 1 {
                    return true;
                }
            }
        }
        false
    }
}