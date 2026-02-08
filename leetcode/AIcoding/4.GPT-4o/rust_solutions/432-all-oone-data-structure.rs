use std::collections::{HashMap, HashSet};

struct AllOne {
    count: HashMap<String, i32>,
    freq: HashMap<i32, HashSet<String>>,
    min_freq: i32,
    max_freq: i32,
}

impl AllOne {

    fn new() -> Self {
        AllOne {
            count: HashMap::new(),
            freq: HashMap::new(),
            min_freq: 0,
            max_freq: 0,
        }
    }

    fn inc(&mut self, key: String) {
        let prev_freq = *self.count.get(&key).unwrap_or(&0);
        let new_freq = prev_freq + 1;
        self.count.insert(key.clone(), new_freq);

        if prev_freq > 0 {
            self.freq.get_mut(&prev_freq).unwrap().remove(&key);
            if self.freq[&prev_freq].is_empty() {
                self.freq.remove(&prev_freq);
                if prev_freq == self.min_freq {
                    self.min_freq += 1;
                }
            }
        } else if self.min_freq == 0 {
            self.min_freq = 1;
        }

        self.freq.entry(new_freq).or_default().insert(key);
        self.max_freq = self.max_freq.max(new_freq);
    }

    fn dec(&mut self, key: String) {
        if let Some(&prev_freq) = self.count.get(&key) {
            let new_freq = prev_freq - 1;
            if new_freq > 0 {
                self.count.insert(key.clone(), new_freq);
                self.freq.get_mut(&prev_freq).unwrap().remove(&key);
                if self.freq[&prev_freq].is_empty() {
                    self.freq.remove(&prev_freq);
                    if prev_freq == self.max_freq {
                        self.max_freq -= 1;
                    }
                }
                self.freq.entry(new_freq).or_default().insert(key);
            } else {
                self.count.remove(&key);
                self.freq.get_mut(&prev_freq).unwrap().remove(&key);
                if self.freq[&prev_freq].is_empty() {
                    self.freq.remove(&prev_freq);
                    if prev_freq == self.max_freq {
                        self.max_freq -= 1;
                    }
                }
                if prev_freq == self.min_freq {
                    if self.freq.is_empty() {
                        self.min_freq = 0;
                    } else {
                        self.min_freq += 1;
                    }
                }
            }
        }
    }

    fn get_max_key(&self) -> String {
        if self.max_freq == 0 {
            return "".to_string();
        }
        self.freq[&self.max_freq].iter().next().unwrap().clone()
    }

    fn get_min_key(&self) -> String {
        if self.min_freq == 0 {
            return "".to_string();
        }
        self.freq[&self.min_freq].iter().next().unwrap().clone()
    }
}