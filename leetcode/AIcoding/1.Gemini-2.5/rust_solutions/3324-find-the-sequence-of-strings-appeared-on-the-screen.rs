impl Solution {
    pub fn find_longest_word(s: String, dictionary: Vec<String>) -> String {
        let mut longest_word = String::new();

        for word in dictionary {
            if Self::is_subsequence(&word, &s) {
                if word.len() > longest_word.len() {
                    longest_word = word;
                } else if word.len() == longest_word.len() {
                    if word < longest_word {
                        longest_word = word;
                    }
                }
            }
        }

        longest_word
    }

    fn is_subsequence(word: &str, s: &str) -> bool {
        let mut i = 0; 
        let mut j = 0; 

        let s_chars: Vec<char> = s.chars().collect();
        let word_chars: Vec<char> = word.chars().collect();

        while i < s_chars.len() && j < word_chars.len() {
            if s_chars[i] == word_chars[j] {
                j += 1;
            }
            i += 1;
        }

        j == word_chars.len()
    }
}