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
        self.tweets.entry(tweet_name).or_insert(Vec::new()).push(time);
    }

    fn get_tweet_counts_per_frequency(
        &mut self,
        freq: String,
        tweet_name: String,
        start_time: i32,
        end_time: i32,
    ) -> Vec<i32> {
        let mut interval = 0;
        match freq.as_str() {
            "minute" => interval = 60,
            "hour" => interval = 3600,
            "day" => interval = 86400,
            _ => {}
        }

        let mut result: Vec<i32> = Vec::new();
        let mut counts: Vec<i32> = vec![0; ((end_time - start_time) / interval) as usize + 1];

        if let Some(times) = self.tweets.get_mut(&tweet_name) {
            times.sort();
            for &time in times {
                if time >= start_time && time <= end_time {
                    let index = ((time - start_time) / interval) as usize;
                    counts[index] += 1;
                }
            }
        }

        result.extend(counts);
        result
    }
}