impl Solution {

use std::collections::{HashMap, BTreeSet};

struct LFUCache {
    capacity: usize,
    cache: HashMap<i32, (i32, usize)>,
    freq_map: HashMap<usize, BTreeSet<i32>>,
    min_freq: usize,
}

impl LFUCache {
    fn new(capacity: i32) -> Self {
        LFUCache {
            capacity: capacity as usize,
            cache: HashMap::new(),
            freq_map: HashMap::new(),
            min_freq: 1,
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if let Some((value, freq)) = self.cache.get_mut(&key) {
            let old_freq = *freq;
            self.freq_map.get_mut(&old_freq).unwrap().remove(&key);
            if self.freq_map[&old_freq].is_empty() {
                self.freq_map.remove(&old_freq);
                if self.min_freq == old_freq {
                    self.min_freq += 1;
                }
            }
            *freq += 1;
            self.freq_map.entry(*freq).or_insert_with(BTreeSet::new).insert(key);
            return *value;
        }
        -1
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.capacity == 0 {
            return;
        }

        if let Some(entry) = self.cache.get_mut(&key) {
            let old_freq = entry.1;
            self.freq_map.get_mut(&old_freq).unwrap().remove(&key);
            if self.freq_map[&old_freq].is_empty() {
                self.freq_map.remove(&old_freq);
                if self.min_freq == old_freq {
                    self.min_freq += 1;
                }
            }
            entry.0 = value;
            entry.1 += 1;
            self.freq_map.entry(entry.1).or_insert_with(BTreeSet::new).insert(key);
            return;
        }

        if self.cache.len() >= self.capacity {
            let evict_key = self.freq_map.get(&self.min_freq).unwrap().iter().next().unwrap();
            self.cache.remove(evict_key);
            self.freq_map.get_mut(&self.min_freq).unwrap().remove(evict_key);
            if self.freq_map[&self.min_freq].is_empty() {
                self.freq_map.remove(&self.min_freq);
            }
        }

        self.cache.insert(key, (value, 1));
        self.freq_map.entry(1).or_insert_with(BTreeSet::new).insert(key);
        self.min_freq = 1;
    }
}
}