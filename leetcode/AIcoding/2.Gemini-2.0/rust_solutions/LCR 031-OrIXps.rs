use std::collections::HashMap;
use std::collections::LinkedList;

struct LRUCache {
    capacity: i32,
    cache: HashMap<i32, i32>,
    queue: LinkedList<i32>,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        LRUCache {
            capacity,
            cache: HashMap::new(),
            queue: LinkedList::new(),
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        match self.cache.get(&key) {
            Some(&value) => {
                self.queue.retain(|&x| x != key);
                self.queue.push_front(key);
                value
            }
            None => -1,
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.cache.contains_key(&key) {
            self.cache.insert(key, value);
            self.queue.retain(|&x| x != key);
            self.queue.push_front(key);
            return;
        }

        if self.cache.len() as i32 == self.capacity {
            if let Some(lru_key) = self.queue.pop_back() {
                self.cache.remove(&lru_key);
            }
        }

        self.cache.insert(key, value);
        self.queue.push_front(key);
    }
}