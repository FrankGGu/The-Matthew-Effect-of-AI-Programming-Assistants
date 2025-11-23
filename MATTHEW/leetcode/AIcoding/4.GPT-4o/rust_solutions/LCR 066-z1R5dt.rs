use std::collections::HashMap;

struct MyHashMap {
    map: HashMap<i32, i32>,
}

impl MyHashMap {
    fn new() -> Self {
        MyHashMap {
            map: HashMap::new(),
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        self.map.insert(key, value);
    }

    fn get(&self, key: i32) -> i32 {
        *self.map.get(&key).unwrap_or(&-1)
    }

    fn remove(&mut self, key: i32) {
        self.map.remove(&key);
    }
}