use std::collections::HashMap;

impl Solution {
    pub fn sender_with_largest_word_count(messages: Vec<String>, senders: Vec<String>) -> String {
        let mut sender_word_counts: HashMap<String, i32> = HashMap::new();

        for i in 0..messages.len() {
            let message = &messages[i];
            let sender = &senders[i];

            let word_count = message.split_whitespace().count() as i32;

            *sender_word_counts.entry(sender.clone()).or_insert(0) += word_count;
        }

        let mut max_word_count = 0;
        let mut result_sender_name = String::new();

        for (sender_name, &count) in sender_word_counts.iter() {
            if count > max_word_count {
                max_word_count = count;
                result_sender_name = sender_name.clone();
            } else if count == max_word_count {
                if sender_name.cmp(&result_sender_name) == std::cmp::Ordering::Greater {
                    result_sender_name = sender_name.clone();
                }
            }
        }

        result_sender_name
    }
}