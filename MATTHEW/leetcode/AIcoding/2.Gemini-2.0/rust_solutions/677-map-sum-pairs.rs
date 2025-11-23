use std::collections::HashMap;

struct MapSum {
    map: HashMap<String, i32>,
}

impl MapSum {
    fn new() -> Self {
        MapSum {
            map: HashMap::new(),
        }
    }

    fn insert(&mut self, key: String, val: i32) {
        self.map.insert(key, val);
    }

    fn sum(&self, prefix: String) -> i32 {
        let mut sum = 0;
        for (key, &val) in &self.map {
            if key.starts_with(&prefix) {
                sum += val;
            }
        }
        sum
    }
}