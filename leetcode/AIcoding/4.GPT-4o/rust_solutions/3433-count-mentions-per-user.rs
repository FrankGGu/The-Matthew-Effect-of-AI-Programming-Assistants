use std::collections::HashMap;

pub fn count_mentions(posts: Vec<String>) -> HashMap<String, i32> {
    let mut mentions = HashMap::new();
    for post in posts {
        let words: Vec<&str> = post.split_whitespace().collect();
        for word in words {
            if word.starts_with('@') {
                let user = word[1..].to_string();
                *mentions.entry(user).or_insert(0) += 1;
            }
        }
    }
    mentions
}