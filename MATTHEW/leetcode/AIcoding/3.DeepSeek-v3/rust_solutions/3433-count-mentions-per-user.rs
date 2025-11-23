use std::collections::HashMap;

impl Solution {
    pub fn count_mentions(tweets: Vec<String>, users: Vec<String>) -> Vec<i32> {
        let mut mention_counts = HashMap::new();

        for tweet in tweets {
            let words: Vec<&str> = tweet.split_whitespace().collect();
            for word in words {
                if word.starts_with('@') {
                    let username = &word[1..];
                    *mention_counts.entry(username.to_string()).or_insert(0) += 1;
                }
            }
        }

        users.iter()
            .map(|user| *mention_counts.get(user).unwrap_or(&0))
            .collect()
    }
}