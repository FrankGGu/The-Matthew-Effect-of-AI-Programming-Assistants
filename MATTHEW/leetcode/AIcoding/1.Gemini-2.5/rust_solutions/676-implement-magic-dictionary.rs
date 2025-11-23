use std::collections::HashSet;

struct MagicDictionary {
    words: HashSet<String>,
}

impl MagicDictionary {
    fn new() -> Self {
        MagicDictionary {
            words: HashSet::new(),
        }
    }

    fn build_dict(&mut self, dictionary: Vec<String>) {
        for word in dictionary {
            self.words.insert(word);
        }
    }

    fn search(&self, search_word: String) -> bool {
        for dict_word in &self.words {
            if dict_word.len() != search_word.len() {
                continue;
            }

            let mut diff_count = 0;
            let mut dict_chars = dict_word.chars();
            let mut search_chars = search_word.chars();

            for _ in 0..dict_word.len() {
                if dict_chars.next().unwrap() != search_chars.next().unwrap() {
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