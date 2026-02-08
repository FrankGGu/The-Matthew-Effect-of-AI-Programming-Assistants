impl Solution {
    pub fn get_words_in_longest_subsequence(n: i32, words: Vec<String>, groups: Vec<i32>) -> Vec<String> {
        let mut result = Vec::new();
        let mut prev_group = -1;

        for i in 0..n as usize {
            if groups[i] != prev_group {
                result.push(words[i].clone());
                prev_group = groups[i];
            }
        }

        result
    }
}