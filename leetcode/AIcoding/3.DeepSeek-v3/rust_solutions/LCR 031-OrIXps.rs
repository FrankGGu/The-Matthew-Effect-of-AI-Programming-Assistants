use std::collections::HashMap;

struct LRUCache {
    capacity: usize,
    cache: HashMap<i32, (i32, usize)>,
    order: Vec<i32>,
    counter: usize,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        LRUCache {
            capacity: capacity as usize,
            cache: HashMap::new(),
            order: Vec::new(),
            counter: 0,
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        self.counter += 1;
        if let Some((value, timestamp)) = self.cache.get_mut(&key) {
            *timestamp = self.counter;
            self.order.retain(|&k| k != key);
            self.order.push(key);
            *value
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        self.counter += 1;
        if let Some(entry) = self.cache.get_mut(&key) {
            entry.0 = value;
            entry.1 = self.counter;
            self.order.retain(|&k| k != key);
            self.order.push(key);
        } else {
            if self.cache.len() >= self.capacity {
                let mut lru_key = -1;
                let mut min_timestamp = usize::MAX;
                for (&k, &(_, ts)) in &self.cache {
                    if ts < min_timestamp {
                        min_timestamp = ts;
                        lru_key = k;
                    }
                }
                if lru_key != -1 {
                    self.cache.remove(&lru_key);
                    self.order.retain(|&k| k != lru_key);
                }
            }
            self.cache.insert(key, (value, self.counter));
            self.order.push(key);
        }
    }
}