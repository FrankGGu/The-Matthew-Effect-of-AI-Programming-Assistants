impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn largest_word_count(messages: Vec<String>, senders: Vec<String>) -> String {
        let mut count = HashMap::new();
        for (i, sender) in senders.iter().enumerate() {
            let message = &messages[i];
            let words = message.split_whitespace().count();
            *count.entry(sender.clone()).or_insert(0) += words;
        }

        let mut max_count = 0;
        let mut result = String::new();
        for (sender, &c) in &count {
            if c > max_count || (c == max_count && sender < &result) {
                max_count = c;
                result = sender.clone();
            }
        }

        result
    }
}
}