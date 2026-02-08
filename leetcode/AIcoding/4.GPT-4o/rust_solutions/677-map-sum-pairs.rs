use std::collections::HashMap;

struct MapSum {
    map: HashMap<String, i32>,
    sum_map: HashMap<String, i32>,
}

impl MapSum {
    fn new() -> Self {
        MapSum {
            map: HashMap::new(),
            sum_map: HashMap::new(),
        }
    }

    fn insert(&mut self, key: String, val: i32) {
        let old_val = self.map.get(&key).cloned().unwrap_or(0);
        self.map.insert(key.clone(), val);
        let delta = val - old_val;

        for i in 1..=key.len() {
            let prefix = &key[..i];
            *self.sum_map.entry(prefix.to_string()).or_insert(0) += delta;
        }
    }

    fn sum(&self, prefix: String) -> i32 {
        self.sum_map.get(&prefix).cloned().unwrap_or(0)
    }
}