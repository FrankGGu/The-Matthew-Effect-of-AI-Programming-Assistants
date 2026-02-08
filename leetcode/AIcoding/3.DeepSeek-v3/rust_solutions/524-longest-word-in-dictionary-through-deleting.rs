impl Solution {
    pub fn find_longest_word(s: String, dictionary: Vec<String>) -> String {
        let mut result = String::new();
        let s_chars: Vec<char> = s.chars().collect();

        for word in dictionary {
            let word_chars: Vec<char> = word.chars().collect();
            let mut i = 0;
            let mut j = 0;

            while i < s_chars.len() && j < word_chars.len() {
                if s_chars[i] == word_chars[j] {
                    j += 1;
                }
                i += 1;
            }

            if j == word_chars.len() {
                if word.len() > result.len() || (word.len() == result.len() && word < result) {
                    result = word;
                }
            }
        }

        result
    }
}