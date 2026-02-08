use std::collections::HashMap;
use std::collections::VecDeque;

struct LRUCache {
    capacity: usize,
    map: HashMap<i32, i32>,
    order: VecDeque<i32>,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        LRUCache {
            capacity: capacity as usize,
            map: HashMap::new(),
            order: VecDeque::new(),
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if let Some(&value) = self.map.get(&key) {
            self.order.retain(|&k| k != key);
            self.order.push_back(key);
            value
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.map.contains_key(&key) {
            self.map.insert(key, value);
            self.order.retain(|&k| k != key);
        } else {
            if self.map.len() == self.capacity {
                if let Some(&old_key) = self.order.front() {
                    self.map.remove(&old_key);
                    self.order.pop_front();
                }
            }
            self.map.insert(key, value);
        }
        self.order.push_back(key);
    }
}