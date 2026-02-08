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
        if let Some(list) = self.map.get(&key) {
            let idx = match list.binary_search_by(|(t, _)| t.cmp(&timestamp)) {
                Ok(i) => i,
                Err(i) => i - 1,
            };
            if idx < list.len() {
                return list[idx].1.clone();
            }
        }
        String::new()
    }
}