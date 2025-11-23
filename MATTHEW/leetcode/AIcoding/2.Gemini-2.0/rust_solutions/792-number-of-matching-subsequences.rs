impl Solution {
    pub fn num_matching_subsequences(s: String, words: Vec<String>) -> i32 {
        let mut count = 0;
        let s_bytes = s.as_bytes();
        for word in words {
            let word_bytes = word.as_bytes();
            let mut i = 0;
            let mut j = 0;
            while i < s_bytes.len() && j < word_bytes.len() {
                if s_bytes[i] == word_bytes[j] {
                    j += 1;
                }
                i += 1;
            }
            if j == word_bytes.len() {
                count += 1;
            }
        }
        count
    }
}