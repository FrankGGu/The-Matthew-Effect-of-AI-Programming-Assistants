use std::collections::HashMap;

struct TweetCounts {
    counts: HashMap<String, Vec<i32>>,
}

impl TweetCounts {
    fn new() -> Self {
        TweetCounts {
            counts: HashMap::new(),
        }
    }

    fn record_tweet(&mut self, tweet_id: String, time: i32) {
        self.counts.entry(tweet_id).or_insert(vec![0; 3600]).push(time);
        self.counts.get_mut(&tweet_id).unwrap()[time as usize / 60] += 1;
    }

    fn get_tweet_counts_per_frequency(&self, freq: String, tweet_id: String, start_time: i32, end_time: i32) -> Vec<i32> {
        let mut result = vec![0; match freq.as_str() {
            "minute" => (end_time - start_time) / 60 + 1,
            "hour" => (end_time - start_time) / 3600 + 1,
            _ => (end_time - start_time) / 86400 + 1,
        }];

        if let Some(times) = self.counts.get(&tweet_id) {
            for i in start_time..=end_time {
                let index = match freq.as_str() {
                    "minute" => (i - start_time) / 60,
                    "hour" => (i - start_time) / 3600,
                    _ => (i - start_time) / 86400,
                };
                if index < result.len() as i32 {
                    result[index as usize] += times[i as usize / 60];
                }
            }
        }

        result
    }
}