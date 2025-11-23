struct WordFilter {
    words: Vec<String>,
}

impl WordFilter {
    fn new(words: Vec<String>) -> Self {
        WordFilter { words }
    }

    fn f(&self, prefix: String, suffix: String) -> i32 {
        let mut res = -1;
        for (i, word) in self.words.iter().enumerate() {
            if word.starts_with(&prefix) && word.ends_with(&suffix) {
                res = i as i32;
            }
        }
        res
    }
}