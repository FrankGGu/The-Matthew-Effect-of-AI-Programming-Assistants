struct MagicDictionary {
    words: Vec<String>,
}

impl MagicDictionary {
    fn new() -> Self {
        MagicDictionary {
            words: Vec::new(),
        }
    }

    fn build_dict(&mut self, dictionary: Vec<String>) {
        self.words = dictionary;
    }

    fn search(&self, search_word: String) -> bool {
        for dict_word in &self.words {
            if dict_word.len() != search_word.len() {
                continue;
            }

            let mut diff_count = 0;
            let dict_bytes = dict_word.as_bytes();
            let search_bytes = search_word.as_bytes();

            for i in 0..dict_bytes.len() {
                if dict_bytes[i] != search_bytes[i] {
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
        false
    }
}