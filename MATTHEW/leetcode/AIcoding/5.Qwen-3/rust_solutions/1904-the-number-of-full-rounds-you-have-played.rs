impl Solution {

use std::time::{Duration, SystemTime};

struct Solution;

impl Solution {
    pub fn number_of_full_rounds(start: String, end: String) -> i32 {
        fn parse_time(time_str: &str) -> Duration {
            let parts: Vec<&str> = time_str.split(':').collect();
            let hours = parts[0].parse::<u64>().unwrap();
            let minutes = parts[1].parse::<u64>().unwrap();
            Duration::from_secs(hours * 60 * 60 + minutes * 60)
        }

        let start_dur = parse_time(&start);
        let end_dur = parse_time(&end);

        if end_dur < start_dur {
            return 0;
        }

        let start_rounded = (start_dur.as_secs() / 60) * 60;
        let end_rounded = (end_dur.as_secs() / 60) * 60;

        if start_rounded > end_dur.as_secs() {
            return 0;
        }

        ((end_rounded - start_rounded) / 60) as i32
    }
}
}