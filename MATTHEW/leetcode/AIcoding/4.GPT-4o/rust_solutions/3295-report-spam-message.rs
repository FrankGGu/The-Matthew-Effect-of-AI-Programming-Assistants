pub fn report_spam(messages: Vec<String>, spam_keywords: Vec<String>) -> Vec<String> {
    let spam_set: std::collections::HashSet<_> = spam_keywords.iter().collect();
    messages.into_iter().filter(|msg| {
        msg.split_whitespace().any(|word| spam_set.contains(word))
    }).collect()
}