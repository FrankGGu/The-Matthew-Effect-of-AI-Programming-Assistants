use std::collections::HashSet;

struct MagicDictionary {
    dict: HashSet<String>,
}

impl MagicDictionary {

    fn new() -> Self {
        MagicDictionary {
            dict: HashSet::new(),
        }
    }

    fn build_dict(&mut self, dict: Vec<String>) {
        for word in dict {
            self.dict.insert(word);
        }
    }

    fn search(&self, search_word: String) -> bool {
        for word in &self.dict {
            if word.len() == search_word.len() {
                let mut diff_count = 0;
                for (a, b) in word.chars().zip(search_word.chars()) {
                    if a != b {
                        diff_count += 1;
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