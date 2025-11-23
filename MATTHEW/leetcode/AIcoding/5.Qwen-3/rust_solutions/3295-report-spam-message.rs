impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn report_spam_message(message: String, banned_words: Vec<String>, k: i32) -> bool {
        let mut word_count = HashSet::new();
        let mut count = 0;

        for word in message.split_whitespace() {
            if banned_words.contains(word) {
                count += 1;
                if count >= k {
                    return true;
                }
            }
        }

        false
    }
}
}