use std::collections::{HashMap, HashSet, VecDeque};

struct Twitter {
    users: HashMap<i32, HashSet<i32>>,
    tweets: VecDeque<(i32, i32)>,
}

impl Twitter {
    fn new() -> Self {
        Twitter {
            users: HashMap::new(),
            tweets: VecDeque::new(),
        }
    }

    fn post_tweet(&mut self, user_id: i32, tweet_id: i32) {
        self.tweets.push_front((user_id, tweet_id));
    }

    fn get_news_feed(&self, user_id: i32) -> Vec<i32> {
        let mut feed = Vec::new();
        let following = self.users.get(&user_id).cloned().unwrap_or_default();
        for &(uid, tid) in &self.tweets {
            if uid == user_id || following.contains(&uid) {
                feed.push(tid);
                if feed.len() == 10 {
                    break;
                }
            }
        }
        feed
    }

    fn follow(&mut self, follower_id: i32, followee_id: i32) {
        self.users.entry(follower_id).or_default().insert(followee_id);
    }

    fn unfollow(&mut self, follower_id: i32, followee_id: i32) {
        if let Some(following) = self.users.get_mut(&follower_id) {
            following.remove(&followee_id);
        }
    }
}