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
        self.map.entry(key).or_default().push((timestamp, value));
    }

    fn get(&self, key: String, timestamp: i32) -> String {
        if let Some(values) = self.map.get(&key) {
            match values.binary_search_by(|(ts, _)| ts.cmp(&timestamp)) {
                Ok(idx) => {
                    values[idx].1.clone()
                }
                Err(idx) => {
                    if idx == 0 {
                        "".to_string()
                    } else {
                        values[idx - 1].1.clone()
                    }
                }
            }
        } else {
            "".to_string()
        }
    }
}