impl Solution {
    pub fn count_consistent_strings(allowed: String, words: Vec<String>) -> i32 {
        let mut allowed_chars = [false; 26];
        for c in allowed.chars() {
            allowed_chars[(c as u8 - b'a') as usize] = true;
        }

        let mut consistent_count = 0;
        'word_loop: for word in words {
            for c in word.chars() {
                if !allowed_chars[(c as u8 - b'a') as usize] {
                    continue 'word_loop;
                }
            }
            consistent_count += 1;
        }

        consistent_count
    }
}