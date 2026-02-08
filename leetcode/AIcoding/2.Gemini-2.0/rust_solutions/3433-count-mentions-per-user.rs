use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct Mention {
    pub user_id: i32,
    pub mentioned_user_id: i32,
}

impl Mention {
    pub fn new(user_id: i32, mentioned_user_id: i32) -> Self {
        Mention {
            user_id,
            mentioned_user_id,
        }
    }
}

pub fn count_mentions(mentions: Vec<Mention>) -> HashMap<i32, i32> {
    let mut mention_counts: HashMap<i32, i32> = HashMap::new();

    for mention in mentions {
        let count = mention_counts.entry(mention.user_id).or_insert(0);
        *count += 1;
    }

    mention_counts
}