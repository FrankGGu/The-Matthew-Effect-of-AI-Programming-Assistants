use std::collections::{HashMap, HashSet};

struct Twitter {
    tweets: Vec<(i32, i32)>, // (userId, tweetId)
    followees: HashMap<i32, HashSet<i32>>, // userId -> set of followeeIds
    timestamp: i32,
}

impl Twitter {
    fn new() -> Self {
        Twitter {
            tweets: Vec::new(),
            followees: HashMap::new(),
            timestamp: 0,
        }
    }

    fn post_tweet(&mut self, user_id: i32, tweet_id: i32) {
        self.tweets.push((user_id, tweet_id));
        self.timestamp += 1;
    }

    fn get_news_feed(&self, user_id: i32) -> Vec<i32> {
        let mut feed = Vec::new();
        let mut relevant_users = HashSet::new();
        relevant_users.insert(user_id);

        if let Some(followees) = self.followees.get(&user_id) {
            for &followee in followees {
                relevant_users.insert(followee);
            }
        }

        let mut count = 0;
        for i in (0..self.tweets.len()).rev() {
            let (tweet_user_id, tweet_id) = self.tweets[i];
            if relevant_users.contains(&tweet_user_id) {
                feed.push(tweet_id);
                count += 1;
                if count == 10 {
                    break;
                }
            }
        }

        feed
    }

    fn follow(&mut self, follower_id: i32, followee_id: i32) {
        self.followees.entry(follower_id).or_insert(HashSet::new()).insert(followee_id);
    }

    fn unfollow(&mut self, follower_id: i32, followee_id: i32) {
        if let Some(followees) = self.followees.get_mut(&follower_id) {
            followees.remove(&followee_id);
        }
    }
}