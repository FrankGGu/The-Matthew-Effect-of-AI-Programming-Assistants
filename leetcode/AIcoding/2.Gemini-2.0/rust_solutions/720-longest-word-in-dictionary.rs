impl Solution {
    pub fn find_longest_word(s: String, dictionary: Vec<String>) -> String {
        let mut longest = String::new();
        for word in dictionary {
            if Self::is_subsequence(&word, &s) {
                if word.len() > longest.len() || (word.len() == longest.len() && word < longest) {
                    longest = word;
                }
            }
        }
        longest
    }

    fn is_subsequence(word: &str, s: &str) -> bool {
        let mut i = 0;
        let mut j = 0;
        while i < word.len() && j < s.len() {
            if word.chars().nth(i) == s.chars().nth(j) {
                i += 1;
            }
            j += 1;
        }
        i == word.len()
    }
}