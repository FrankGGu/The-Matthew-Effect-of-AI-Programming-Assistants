use std::collections::HashMap;

impl Solution {
    pub fn largest_word_count(messages: Vec<String>, senders: Vec<String>) -> String {
        let mut sender_word_count = HashMap::new();

        for (sender, message) in senders.iter().zip(messages.iter()) {
            let count = message.split_whitespace().count();
            *sender_word_count.entry(sender).or_insert(0) += count;
        }

        let mut max_count = 0;
        let mut result = String::new();

        for (sender, &count) in sender_word_count.iter() {
            if count > max_count || (count == max_count && *sender > result) {
                max_count = count;
                result = sender.clone();
            }
        }

        result
    }
}