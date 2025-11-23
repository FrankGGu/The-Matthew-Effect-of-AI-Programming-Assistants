impl Solution {
    pub fn get_words_in_longest_subsequence(n: i32, words: Vec<String>, groups: Vec<i32>) -> Vec<String> {
        let mut ans = vec![words[0].clone()];
        let mut prev_group = groups[0];
        for i in 1..n as usize {
            if groups[i] != prev_group {
                ans.push(words[i].clone());
                prev_group = groups[i];
            }
        }
        ans
    }
}