use std::collections::{HashMap, VecDeque};

struct LFUCache {
    capacity: usize,
    min_freq: usize,
    key_value: HashMap<i32, (i32, usize)>,
    freq_list: HashMap<usize, VecDeque<i32>>,
    freq_count: HashMap<i32, usize>,
}

impl LFUCache {
    fn new(capacity: i32) -> Self {
        LFUCache {
            capacity: capacity as usize,
            min_freq: 0,
            key_value: HashMap::new(),
            freq_list: HashMap::new(),
            freq_count: HashMap::new(),
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if let Some(&(value, freq)) = self.key_value.get(&key) {
            self.freq_count.insert(key, freq + 1);
            self.freq_list.entry(freq).and_modify(|v| v.retain(|&k| k != key));
            if self.freq_list[&freq].is_empty() {
                self.freq_list.remove(&freq);
                if self.min_freq == freq {
                    self.min_freq += 1;
                }
            }
            self.freq_list.entry(freq + 1).or_default().push_back(key);
            return value;
        }
        -1
    }

    fn put(&mut self, key: i32, value: i32) {
        if self.capacity == 0 {
            return;
        }
        if self.key_value.contains_key(&key) {
            self.key_value.insert(key, (value, self.freq_count[&key]));
            self.get(key);
            return;
        }
        if self.key_value.len() == self.capacity {
            if let Some(old_key) = self.freq_list.get_mut(&self.min_freq).and_then(|v| v.pop_front()) {
                self.key_value.remove(&old_key);
                self.freq_count.remove(&old_key);
            }
        }
        self.key_value.insert(key, (value, 0));
        self.freq_count.insert(key, 0);
        self.min_freq = 0;
        self.freq_list.entry(1).or_default().push_back(key);
    }
}