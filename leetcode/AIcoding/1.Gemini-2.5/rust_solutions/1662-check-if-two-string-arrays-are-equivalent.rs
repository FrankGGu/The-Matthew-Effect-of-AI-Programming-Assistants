impl Solution {
    pub fn array_strings_are_equivalent(word1: Vec<String>, word2: Vec<String>) -> bool {
        word1.join("") == word2.join("")
    }
}