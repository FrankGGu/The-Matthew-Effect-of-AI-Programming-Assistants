impl Solution {
    pub fn longest_beautiful_substring(word: String) -> i32 {
        let chars: Vec<char> = word.chars().collect();
        let n = chars.len();
        let mut max_len = 0;
        let mut current_len = 1;
        let mut vowel_count = 1;

        for i in 1..n {
            if chars[i] >= chars[i - 1] {
                current_len += 1;
                if chars[i] != chars[i - 1] {
                    vowel_count += 1;
                }
            } else {
                current_len = 1;
                vowel_count = 1;
            }

            if vowel_count == 5 {
                max_len = max_len.max(current_len);
            }
        }

        max_len
    }
}