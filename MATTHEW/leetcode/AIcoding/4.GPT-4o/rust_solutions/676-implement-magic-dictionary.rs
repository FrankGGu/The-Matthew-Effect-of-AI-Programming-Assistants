struct MagicDictionary {
    dict: std::collections::HashSet<String>,
}

impl MagicDictionary {

    fn new() -> Self {
        MagicDictionary { dict: std::collections::HashSet::new() }
    }

    fn build_dict(&mut self, dictionary: Vec<String>) {
        self.dict.extend(dictionary);
    }

    fn search(&self, search_word: String) -> bool {
        for word in &self.dict {
            if word.len() == search_word.len() {
                let mut diff_count = 0;
                for (c1, c2) in word.chars().zip(search_word.chars()) {
                    if c1 != c2 {
                        diff_count += 1;
                    }
                    if diff_count > 1 {
                        break;
                    }
                }
                if diff_count == 1 {
                    return true;
                }
            }
        }
        false
    }
}