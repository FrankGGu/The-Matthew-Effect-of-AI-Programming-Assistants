use std::collections::HashMap;

struct TimeMap {
    map: HashMap<String, Vec<(i32, String)>>,
}

impl TimeMap {
    fn new() -> Self {
        TimeMap {
            map: HashMap::new(),
        }
    }

    fn set(&mut self, key: String, value: String, timestamp: i32) {
        self.map.entry(key).or_insert(Vec::new()).push((timestamp, value));
    }

    fn get(&self, key: String, timestamp: i32) -> String {
        if let Some(values) = self.map.get(&key) {
            let mut left = 0;
            let mut right = values.len();
            let mut result = String::new();

            while left < right {
                let mid = left + (right - left) / 2;
                if values[mid].0 <= timestamp {
                    result = values[mid].1.clone();
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }

            result
        } else {
            String::new()
        }
    }
}