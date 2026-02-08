impl Solution {
    pub fn merge_alternately(word1: String, word2: String) -> String {
        let mut result = String::new();
        let (len1, len2) = (word1.len(), word2.len());
        let (mut i, mut j) = (0, 0);

        while i < len1 || j < len2 {
            if i < len1 {
                result.push(word1.chars().nth(i).unwrap());
                i += 1;
            }
            if j < len2 {
                result.push(word2.chars().nth(j).unwrap());
                j += 1;
            }
        }

        result
    }
}