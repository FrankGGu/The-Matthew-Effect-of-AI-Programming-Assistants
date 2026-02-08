use std::collections::HashMap;
use std::collections::BTreeMap;

struct TimeMap {
    map: HashMap<String, BTreeMap<i32, String>>,
}

impl TimeMap {
    fn new() -> Self {
        TimeMap {
            map: HashMap::new(),
        }
    }

    fn set(&mut self, key: String, value: String, timestamp: i32) {
        self.map.entry(key).or_insert(BTreeMap::new()).insert(timestamp, value);
    }

    fn get(&self, key: String, timestamp: i32) -> String {
        if let Some(timestamps) = self.map.get(&key) {
            if let Some((&ts, value)) = timestamps.range(..=timestamp).last() {
                return value.clone();
            }
        }
        "".to_string()
    }
}