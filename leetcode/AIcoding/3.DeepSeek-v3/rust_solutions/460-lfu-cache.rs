use std::collections::HashMap;
use std::collections::HashSet;
use std::collections::VecDeque;

struct LFUCache {
    capacity: usize,
    min_freq: i32,
    key_to_val_freq: HashMap<i32, (i32, i32)>,
    freq_to_keys: HashMap<i32, HashSet<i32>>,
    key_to_freq: HashMap<i32, i32>,
}

impl LFUCache {
    fn new(capacity: i32) -> Self {
        LFUCache {
            capacity: capacity as usize,
            min_freq: 0,
            key_to_val_freq: HashMap::new(),
            freq_to_keys: HashMap::new(),
            key_to_freq: HashMap::new(),
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if let Some((val, freq)) = self.key_to_val_freq.get_mut(&key) {
            let old_freq = *freq;
            *freq += 1;

            self.freq_to_keys.entry(old_freq).and_modify(|set| {
                set.remove(&key);
            });
            if old_freq == self.min_freq && self.freq_to_keys.get(&old_freq).map_or(true, |set| set.is_empty()) {
                self.min_freq += 1;
            }

            self.freq_to_keys.entry(*freq).or_insert_with(HashSet::new).insert(key);
            *val
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.capacity == 0 {
            return;
        }

        if let Some((val, freq)) = self.key_to_val_freq.get_mut(&key) {
            *val = value;
            let old_freq = *freq;
            *freq += 1;

            self.freq_to_keys.entry(old_freq).and_modify(|set| {
                set.remove(&key);
            });
            if old_freq == self.min_freq && self.freq_to_keys.get(&old_freq).map_or(true, |set| set.is_empty()) {
                self.min_freq += 1;
            }

            self.freq_to_keys.entry(*freq).or_insert_with(HashSet::new).insert(key);
        } else {
            if self.key_to_val_freq.len() >= self.capacity {
                let keys = self.freq_to_keys.get_mut(&self.min_freq).unwrap();
                let &key_to_remove = keys.iter().next().unwrap();
                keys.remove(&key_to_remove);
                self.key_to_val_freq.remove(&key_to_remove);
            }

            self.key_to_val_freq.insert(key, (value, 1));
            self.freq_to_keys.entry(1).or_insert_with(HashSet::new).insert(key);
            self.min_freq = 1;
        }
    }
}