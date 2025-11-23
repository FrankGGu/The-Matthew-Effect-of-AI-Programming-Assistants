impl Solution {
    pub fn expressive_words(s: String, words: Vec<String>) -> i32 {
        let mut count = 0;
        for word in &words {
            if Self::is_expressive(&s, &word) {
                count += 1;
            }
        }
        count
    }

    fn is_expressive(s: &str, word: &str) -> bool {
        let mut i = 0;
        let mut j = 0;

        while i < s.len() && j < word.len() {
            if s.chars().nth(i) != word.chars().nth(j) {
                return false;
            }

            let mut s_count = 0;
            let s_char = s.chars().nth(i).unwrap();
            while i < s.len() && s.chars().nth(i).unwrap() == s_char {
                s_count += 1;
                i += 1;
            }

            let mut word_count = 0;
            let word_char = word.chars().nth(j).unwrap();
            while j < word.len() && word.chars().nth(j).unwrap() == word_char {
                word_count += 1;
                j += 1;
            }

            if s_count < word_count {
                return false;
            }

            if s_count != word_count && s_count < 3 {
                return false;
            }
        }

        i == s.len() && j == word.len()
    }
}