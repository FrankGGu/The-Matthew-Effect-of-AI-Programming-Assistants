impl Solution {
    pub fn find_longest_word(s: String, dictionary: Vec<String>) -> String {
        let mut longest_word = String::new();

        for word in dictionary {
            if Self::is_subsequence(&s, &word) {
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

    fn is_subsequence(s_str: &str, t_str: &str) -> bool {
        let mut i = 0; // pointer for s_str
        let mut j = 0; // pointer for t_str

        let s_bytes = s_str.as_bytes();
        let t_bytes = t_str.as_bytes();

        while i < s_bytes.len() && j < t_bytes.len() {
            if s_bytes[i] == t_bytes[j] {
                j += 1;
            }
            i += 1;
        }
        j == t_bytes.len()
    }
}