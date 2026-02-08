use std::collections::{HashMap, HashSet, LinkedList};

struct LFUCache {
    capacity: i32,
    key_to_val: HashMap<i32, i32>,
    key_to_freq: HashMap<i32, i32>,
    freq_to_keys: HashMap<i32, LinkedList<i32>>,
    min_freq: i32,
}

impl LFUCache {
    fn new(capacity: i32) -> Self {
        LFUCache {
            capacity,
            key_to_val: HashMap::new(),
            key_to_freq: HashMap::new(),
            freq_to_keys: HashMap::new(),
            min_freq: 1,
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if self.capacity == 0 {
            return -1;
        }

        if !self.key_to_val.contains_key(&key) {
            return -1;
        }

        let freq = *self.key_to_freq.get(&key).unwrap();
        self.update_freq(key, freq);
        *self.key_to_val.get(&key).unwrap()
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.capacity == 0 {
            return;
        }

        if self.key_to_val.contains_key(&key) {
            self.key_to_val.insert(key, value);
            let freq = *self.key_to_freq.get(&key).unwrap();
            self.update_freq(key, freq);
            return;
        }

        if self.key_to_val.len() as i32 == self.capacity {
            self.evict();
        }

        self.key_to_val.insert(key, value);
        self.key_to_freq.insert(key, 1);

        if !self.freq_to_keys.contains_key(&1) {
            self.freq_to_keys.insert(1, LinkedList::new());
        }
        self.freq_to_keys.get_mut(&1).unwrap().push_back(key);
        self.min_freq = 1;
    }

    fn update_freq(&mut self, key: i32, freq: i32) {
        self.freq_to_keys.get_mut(&freq).unwrap().retain(|&x| x != key);
        if self.freq_to_keys.get(&freq).unwrap().is_empty() {
            self.freq_to_keys.remove(&freq);
            if self.min_freq == freq {
                self.min_freq += 1;
            }
        }

        let new_freq = freq + 1;
        if !self.freq_to_keys.contains_key(&new_freq) {
            self.freq_to_keys.insert(new_freq, LinkedList::new());
        }
        self.freq_to_keys.get_mut(&new_freq).unwrap().push_back(key);
        self.key_to_freq.insert(key, new_freq);
    }

    fn evict(&mut self) {
        let key_to_remove = self.freq_to_keys.get_mut(&self.min_freq).unwrap().pop_front().unwrap();
        self.key_to_val.remove(&key_to_remove);
        self.key_to_freq.remove(&key_to_remove);
        if self.freq_to_keys.get(&self.min_freq).unwrap().is_empty() {
            self.freq_to_keys.remove(&self.min_freq);
        }
    }
}