impl Solution {

use std::collections::{HashMap, HashSet, VecDeque};

struct Twitter {
    user_tweets: HashMap<i32, VecDeque<(i32, i32)>>,
    user_follows: HashMap<i32, HashSet<i32>>,
    time: i32,
}

impl Twitter {
    fn new() -> Self {
        Twitter {
            user_tweets: HashMap::new(),
            user_follows: HashMap::new(),
            time: 0,
        }
    }

    fn post_tweet(&mut self, user_id: i32, tweet_id: i32) {
        self.time += 1;
        self.user_tweets
            .entry(user_id)
            .or_insert_with(VecDeque::new)
            .push_back((tweet_id, self.time));
    }

    fn get_news_feed(&mut self, user_id: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut heap = Vec::new();

        if let Some(follows) = self.user_follows.get(&user_id) {
            for &followed in follows {
                if let Some(tweets) = self.user_tweets.get(&followed) {
                    for tweet in tweets.iter().rev() {
                        heap.push(tweet);
                    }
                }
            }
        }

        if let Some(tweets) = self.user_tweets.get(&user_id) {
            for tweet in tweets.iter().rev() {
                heap.push(tweet);
            }
        }

        heap.sort_by(|a, b| b.1.cmp(&a.1));
        for i in 0..(heap.len().min(10)) {
            result.push(heap[i].0);
        }

        result
    }

    fn follow(&mut self, follower_id: i32, followee_id: i32) {
        self.user_follows
            .entry(follower_id)
            .or_insert_with(HashSet::new)
            .insert(followee_id);
    }

    fn unfollow(&mut self, follower_id: i32, followee_id: i32) {
        if let Some(follows) = self.user_follows.get_mut(&follower_id) {
            follows.remove(&followee_id);
        }
    }
}
}