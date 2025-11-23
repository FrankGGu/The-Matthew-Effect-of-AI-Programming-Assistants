use std::collections::{HashMap, HashSet};

struct Twitter {
    // Stores tweets: user_id -> Vec<(timestamp, tweet_id)>
    // The Vec for each user is implicitly sorted by timestamp because tweets are appended chronologically.
    tweets: HashMap<i32, Vec<(i32, i32)>>,
    // Stores follow relationships: follower_id -> HashSet<followee_id>
    follows: HashMap<i32, HashSet<i32>>,
    // Global timestamp to ensure unique ordering of tweets across all users.
    global_timestamp: i32,
}

impl Twitter {
    fn new() -> Self {
        Twitter {
            tweets: HashMap::new(),
            follows: HashMap::new(),
            global_timestamp: 0,
        }
    }

    fn post_tweet(&mut self, user_id: i32, tweet_id: i32) {
        self.tweets
            .entry(user_id)
            .or_insert_with(Vec::new)
            .push((self.global_timestamp, tweet_id));
        self.global_timestamp += 1;
    }

    fn get_news_feed(&self, user_id: i32) -> Vec<i32> {
        let mut relevant_users: HashSet<i32> = HashSet::new();
        relevant_users.insert(user_id); // A user always sees their own tweets

        // Add users that `user_id` follows to the set of relevant users
        if let Some(followed_users) = self.follows.get(&user_id) {
            relevant_users.extend(followed_users.iter());
        }

        let mut candidate_tweets: Vec<(i32, i32)> = Vec::new(); // Stores (timestamp, tweet_id)

        // Collect up to the 10 most recent tweets from each relevant user
        for &u_id in &relevant_users {
            if let Some(user_tweets) = self.tweets.get(&u_id) {
                // Iterate the user's tweets in reverse to get the most recent ones first.
                // Take up to the last 10 tweets from this user, as older ones are unlikely to be in the top 10 overall.
                for i in (0..user_tweets.len()).rev().take(10) {
                    candidate_tweets.push(user_tweets[i]);
                }
            }
        }

        // Sort all collected candidate tweets by timestamp in descending order
        candidate_tweets.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        // Take the top 10 tweet_ids from the sorted list
        candidate_tweets
            .into_iter()
            .take(10)
            .map(|(_, tweet_id)| tweet_id)
            .collect()
    }

    fn follow(&mut self, follower_id: i32, followee_id: i32) {
        // A user cannot follow themselves
        if follower_id == followee_id {
            return;
        }
        self.follows
            .entry(follower_id)
            .or_insert_with(HashSet::new)
            .insert(followee_id);
    }

    fn unfollow(&mut self, follower_id: i32, followee_id: i32) {
        // A user cannot unfollow themselves
        if follower_id == followee_id {
            return;
        }
        if let Some(followed_users) = self.follows.get_mut(&follower_id) {
            followed_users.remove(&followee_id);
        }
    }
}