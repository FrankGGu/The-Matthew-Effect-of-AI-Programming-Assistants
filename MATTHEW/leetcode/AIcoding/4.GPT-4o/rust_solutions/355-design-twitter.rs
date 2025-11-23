use std::collections::{HashMap, VecDeque};

struct Twitter {
    tweets: HashMap<i32, VecDeque<(i32, i32)>>,
    follows: HashMap<i32, HashMap<i32, bool>>,
    time: i32,
}

impl Twitter {
    fn new() -> Self {
        Twitter {
            tweets: HashMap::new(),
            follows: HashMap::new(),
            time: 0,
        }
    }

    fn post_tweet(&mut self, user_id: i32, tweet_id: i32) {
        self.time += 1;
        self.tweets.entry(user_id).or_insert_with(VecDeque::new).push_front((self.time, tweet_id));
        if let Some(tweets) = self.tweets.get_mut(&user_id) {
            if tweets.len() > 10 {
                tweets.pop_back();
            }
        }
    }

    fn get_news_feed(&mut self, user_id: i32) -> Vec<i32> {
        let mut feeds = Vec::new();
        let mut max_heap = Vec::new();

        for (&followee_id, _) in self.follows.get(&user_id).unwrap_or(&HashMap::new()) {
            if let Some(tweets) = self.tweets.get(&followee_id) {
                if let Some(&(time, tweet_id)) = tweets.front() {
                    max_heap.push((time, tweet_id, followee_id));
                }
            }
        }

        max_heap.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        for &(time, tweet_id, _) in max_heap.iter().take(10) {
            feeds.push(tweet_id);
        }

        feeds
    }

    fn follow(&mut self, follower_id: i32, followee_id: i32) {
        self.follows.entry(follower_id).or_insert_with(HashMap::new).insert(followee_id, true);
    }

    fn unfollow(&mut self, follower_id: i32, followee_id: i32) {
        if let Some(followees) = self.follows.get_mut(&follower_id) {
            followees.remove(&followee_id);
        }
    }
}