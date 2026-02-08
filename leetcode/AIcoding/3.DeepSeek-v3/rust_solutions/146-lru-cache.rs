use std::collections::HashMap;
use std::collections::LinkedList;

struct LRUCache {
    capacity: usize,
    map: HashMap<i32, (i32, usize)>,
    list: LinkedList<(i32, i32)>,
    counter: usize,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        LRUCache {
            capacity: capacity as usize,
            map: HashMap::new(),
            list: LinkedList::new(),
            counter: 0,
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        self.counter += 1;
        if let Some((value, time)) = self.map.get_mut(&key) {
            *time = self.counter;
            *value
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        self.counter += 1;
        if self.map.contains_key(&key) {
            self.map.insert(key, (value, self.counter));
        } else {
            if self.map.len() == self.capacity {
                let mut oldest_key = 0;
                let mut oldest_time = usize::MAX;
                for (&k, &(_, t)) in &self.map {
                    if t < oldest_time {
                        oldest_key = k;
                        oldest_time = t;
                    }
                }
                self.map.remove(&oldest_key);
            }
            self.map.insert(key, (value, self.counter));
        }
    }
}