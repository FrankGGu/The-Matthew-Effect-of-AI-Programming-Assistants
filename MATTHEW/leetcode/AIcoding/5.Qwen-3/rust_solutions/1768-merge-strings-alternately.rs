impl Solution {
    pub fn merge_alternately(word1: String, word2: String) -> String {
        let mut result = String::new();
        let mut i = 0;
        let len1 = word1.len();
        let len2 = word2.len();
        let max_len = std::cmp::max(len1, len2);

        while i < max_len {
            if i < len1 {
                result.push(word1.chars().nth(i).unwrap());
            }
            if i < len2 {
                result.push(word2.chars().nth(i).unwrap());
            }
            i += 1;
        }

        result
    }
}