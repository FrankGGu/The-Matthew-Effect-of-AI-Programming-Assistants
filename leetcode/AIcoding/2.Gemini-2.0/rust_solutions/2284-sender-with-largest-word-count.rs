use std::collections::HashMap;

impl Solution {
    pub fn largest_word_count(messages: Vec<String>, senders: Vec<String>) -> String {
        let mut word_counts: HashMap<String, i32> = HashMap::new();

        for i in 0..messages.len() {
            let message = &messages[i];
            let sender = &senders[i];

            let word_count = message.split_whitespace().count() as i32;

            *word_counts.entry(sender.clone()).or_insert(0) += word_count;
        }

        let mut max_count = 0;
        let mut largest_sender = String::new();

        for (sender, count) in word_counts.iter() {
            if *count > max_count {
                max_count = *count;
                largest_sender = sender.clone();
            } else if *count == max_count {
                if sender > &largest_sender {
                    largest_sender = sender.clone();
                }
            }
        }

        largest_sender
    }
}