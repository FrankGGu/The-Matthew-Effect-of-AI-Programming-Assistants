struct Solution;

impl Solution {
    pub fn max_repeating(word: String, pattern: String) -> i32 {
        let mut count = 0;
        let mut current = 0;
        let mut i = 0;
        let len_word = word.len();
        let len_pattern = pattern.len();

        while i <= len_word - len_pattern {
            if &word[i..i + len_pattern] == &pattern {
                current += 1;
                i += len_pattern;
                count = count.max(current);
            } else {
                i += 1;
                current = 0;
            }
        }

        count
    }
}