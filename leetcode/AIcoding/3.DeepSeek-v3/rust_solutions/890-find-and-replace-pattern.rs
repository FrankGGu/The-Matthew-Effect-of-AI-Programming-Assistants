impl Solution {
    pub fn find_and_replace_pattern(words: Vec<String>, pattern: String) -> Vec<String> {
        let pattern = pattern.as_bytes();
        words.into_iter().filter(|word| {
            let word = word.as_bytes();
            if word.len() != pattern.len() {
                return false;
            }
            let mut word_to_pat = [0; 26];
            let mut pat_to_word = [0; 26];
            for i in 0..word.len() {
                let w = (word[i] - b'a') as usize;
                let p = (pattern[i] - b'a') as usize;
                if word_to_pat[w] == 0 && pat_to_word[p] == 0 {
                    word_to_pat[w] = p + 1;
                    pat_to_word[p] = w + 1;
                } else if word_to_pat[w] != p + 1 || pat_to_word[p] != w + 1 {
                    return false;
                }
            }
            true
        }).collect()
    }
}