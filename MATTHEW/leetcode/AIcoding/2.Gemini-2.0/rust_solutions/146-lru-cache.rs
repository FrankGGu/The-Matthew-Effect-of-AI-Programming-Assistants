use std::collections::HashMap;
use std::collections::LinkedList;

struct LRUCache {
    capacity: i32,
    map: HashMap<i32, i32>,
    queue: LinkedList<i32>,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        LRUCache {
            capacity,
            map: HashMap::new(),
            queue: LinkedList::new(),
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if self.map.contains_key(&key) {
            let value = *self.map.get(&key).unwrap();
            self.queue.retain(|&x| x != key);
            self.queue.push_front(key);
            value
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.map.contains_key(&key) {
            self.map.insert(key, value);
            self.queue.retain(|&x| x != key);
            self.queue.push_front(key);
            return;
        }

        if self.map.len() as i32 == self.capacity {
            if let Some(lru_key) = self.queue.pop_back() {
                self.map.remove(&lru_key);
            }
        }

        self.map.insert(key, value);
        self.queue.push_front(key);
    }
}