impl Solution {
    pub fn largest_merge(word1: String, word2: String) -> String {
        let (mut i, mut j) = (0, 0);
        let (n1, n2) = (word1.len(), word2.len());
        let mut result = String::new();

        while i < n1 || j < n2 {
            if &word1[i..] >= &word2[j..] {
                result.push(word1.chars().nth(i).unwrap());
                i += 1;
            } else {
                result.push(word2.chars().nth(j).unwrap());
                j += 1;
            }
        }

        result
    }
}