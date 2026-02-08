use std::collections::HashMap;

pub fn largest_word_count(messages: Vec<String>, senders: Vec<String>) -> String {
    let mut word_count: HashMap<String, usize> = HashMap::new();

    for (i, message) in messages.iter().enumerate() {
        let count = message.split_whitespace().count();
        let sender = &senders[i];
        *word_count.entry(sender.clone()).or_insert(0) += count;
    }

    word_count.into_iter().max_by(|a, b| {
        if a.1 == b.1 {
            a.0.cmp(&b.0)
        } else {
            a.1.cmp(&b.1)
        }
    }).unwrap().0
}