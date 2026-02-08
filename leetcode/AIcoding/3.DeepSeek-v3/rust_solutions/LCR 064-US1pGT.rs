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
        let chars: Vec<char> = search_word.chars().collect();
        for i in 0..chars.len() {
            let original_char = chars[i];
            for c in 'a'..='z' {
                if c == original_char {
                    continue;
                }
                let mut new_chars = chars.clone();
                new_chars[i] = c;
                let new_word: String = new_chars.iter().collect();
                if self.words.contains(&new_word) {
                    return true;
                }
            }
        }
        false
    }
}