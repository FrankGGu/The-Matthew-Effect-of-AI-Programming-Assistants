impl Solution {
    pub fn merge_alternately(word1: String, word2: String) -> String {
        let mut result = String::new();
        let len1 = word1.len();
        let len2 = word2.len();
        let mut i = 0;
        let mut j = 0;

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