use std::collections::HashMap;

fn report_spam_messages(messages: Vec<Vec<String>>) -> Vec<String> {
    let mut spam_counts: HashMap<String, i32> = HashMap::new();
    let mut result: Vec<String> = Vec::new();

    for message in messages {
        let sender = &message[0];
        let content = &message[1];

        let count = spam_counts.entry(sender.clone()).or_insert(0);
        *count += 1;

        if *count >= 3 {
            result.push(sender.clone());
            spam_counts.remove(sender);
        }
    }

    result
}