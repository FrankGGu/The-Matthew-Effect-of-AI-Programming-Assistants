impl Solution {
    pub fn largest_merge(word1: String, word2: String) -> String {
        let mut result = String::new();
        let mut i = 0;
        let mut j = 0;
        let word1_bytes = word1.as_bytes();
        let word2_bytes = word2.as_bytes();

        while i < word1_bytes.len() || j < word2_bytes.len() {
            if i < word1_bytes.len() && j < word2_bytes.len() {
                if word1_bytes[i..] > word2_bytes[j..] {
                    result.push(word1_bytes[i] as char);
                    i += 1;
                } else {
                    result.push(word2_bytes[j] as char);
                    j += 1;
                }
            } else if i < word1_bytes.len() {
                result.push(word1_bytes[i] as char);
                i += 1;
            } else {
                result.push(word2_bytes[j] as char);
                j += 1;
            }
        }

        result
    }
}