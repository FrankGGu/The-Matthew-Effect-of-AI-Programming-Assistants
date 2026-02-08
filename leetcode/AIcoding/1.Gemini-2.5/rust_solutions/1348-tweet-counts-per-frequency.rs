use std::collections::HashMap;

struct TweetCounts {
    tweets: HashMap<String, Vec<i32>>,
}

impl TweetCounts {
    fn new() -> Self {
        TweetCounts {
            tweets: HashMap::new(),
        }
    }

    fn record_tweet(&mut self, tweet_name: String, time: i32) {
        self.tweets.entry(tweet_name).or_default().push(time);
    }

    fn get_tweet_counts_per_frequency(
        &self,
        freq: String,
        tweet_name: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<i32> {
        let interval_size = match freq.as_str() {
            "minute" => 60,
            "hour" => 3600,
            "day" => 86400,
            _ => unreachable!(),
        };

        let num_buckets = ((end_time - start_time) / interval_size) as usize + 1;
        let mut result = vec![0; num_buckets];

        if let Some(times) = self.tweets.get(&tweet_name) {
            for &time in times {
                if time >= start_time && time <= end_time {
                    let bucket_idx = ((time - start_time) / interval_size) as usize;
                    result[bucket_idx] += 1;
                }
            }
        }

        result
    }
}