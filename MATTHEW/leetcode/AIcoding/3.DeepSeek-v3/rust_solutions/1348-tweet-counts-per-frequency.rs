use std::collections::BTreeMap;

struct TweetCounts {
    tweets: BTreeMap<String, BTreeMap<i32, i32>>,
}

impl TweetCounts {
    fn new() -> Self {
        TweetCounts {
            tweets: BTreeMap::new(),
        }
    }

    fn record_tweet(&mut self, tweet_name: String, time: i32) {
        let entry = self.tweets.entry(tweet_name).or_insert(BTreeMap::new());
        *entry.entry(time).or_insert(0) += 1;
    }

    fn get_tweet_counts_per_frequency(&self, freq: String, tweet_name: String, start_time: i32, end_time: i32) -> Vec<i32> {
        let delta = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => 0,
        };

        let mut res = Vec::new();
        if let Some(times) = self.tweets.get(&tweet_name) {
            let mut current_start = start_time;
            while current_start <= end_time {
                let current_end = (current_start + delta - 1).min(end_time);
                let count = times.range(current_start..=current_end).map(|(_, &cnt)| cnt).sum();
                res.push(count);
                current_start += delta;
            }
        }
        res
    }
}