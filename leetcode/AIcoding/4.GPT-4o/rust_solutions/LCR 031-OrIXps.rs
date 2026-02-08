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
            self.order.retain(|&x| x != key);
            self.order.push_back(key);
            return value;
        }
        -1
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.map.contains_key(&key) {
            self.map.insert(key, value);
            self.order.retain(|&x| x != key);
        } else {
            if self.order.len() == self.capacity {
                if let Some(removed_key) = self.order.pop_front() {
                    self.map.remove(&removed_key);
                }
            }
            self.map.insert(key, value);
        }
        self.order.push_back(key);
    }
}