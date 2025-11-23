use std::collections::{HashMap, BTreeSet};

impl Solution {
    pub fn alert_names(key_name: Vec<String>, key_time: Vec<String>) -> Vec<String> {
        let mut name_to_times: HashMap<String, Vec<i32>> = HashMap::new();

        for (name, time_str) in key_name.iter().zip(key_time.iter()) {
            let time = Self::parse_time(time_str);
            name_to_times.entry(name.clone()).or_default().push(time);
        }

        let mut res = BTreeSet::new();

        for (name, times) in name_to_times {
            let mut times = times;
            times.sort_unstable();

            for i in 2..times.len() {
                if times[i] - times[i - 2] <= 60 {
                    res.insert(name);
                    break;
                }
            }
        }

        res.into_iter().collect()
    }

    fn parse_time(time_str: &str) -> i32 {
        let parts: Vec<&str> = time_str.split(':').collect();
        let hours: i32 = parts[0].parse().unwrap();
        let minutes: i32 = parts[1].parse().unwrap();
        hours * 60 + minutes
    }
}