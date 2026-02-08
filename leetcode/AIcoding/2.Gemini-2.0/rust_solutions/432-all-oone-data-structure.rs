use std::collections::{HashMap, HashSet};

struct AllOne {
    map: HashMap<String, i32>,
    buckets: HashMap<i32, HashSet<String>>,
    min_val: i32,
    max_val: i32,
}

impl AllOne {
    fn new() -> Self {
        AllOne {
            map: HashMap::new(),
            buckets: HashMap::new(),
            min_val: 0,
            max_val: 0,
        }
    }

    fn inc(&mut self, key: String) {
        let old_val = self.map.get(&key).copied().unwrap_or(0);
        let new_val = old_val + 1;

        self.map.insert(key.clone(), new_val);

        if old_val > 0 {
            if let Some(set) = self.buckets.get_mut(&old_val) {
                set.remove(&key);
                if set.is_empty() {
                    self.buckets.remove(&old_val);
                    if old_val == self.min_val {
                        if self.buckets.is_empty() {
                            self.min_val = 0;
                        } else {
                            self.min_val = self.buckets.keys().min().copied().unwrap_or(0);
                        }
                    }
                    if old_val == self.max_val && set.is_empty(){
                        self.max_val = self.buckets.keys().max().copied().unwrap_or(0);
                    }
                }
            }
        }

        self.buckets.entry(new_val).or_insert(HashSet::new()).insert(key.clone());

        if self.min_val == 0 || new_val < self.min_val {
            self.min_val = new_val;
        }
        if new_val > self.max_val {
            self.max_val = new_val;
        }
    }

    fn dec(&mut self, key: String) {
        let old_val = self.map.get(&key).copied().unwrap_or(0);
        if old_val == 0 {
            return;
        }

        let new_val = old_val - 1;

        self.map.insert(key.clone(), new_val);

        if let Some(set) = self.buckets.get_mut(&old_val) {
            set.remove(&key);
            if set.is_empty() {
                self.buckets.remove(&old_val);
                if old_val == self.min_val {
                    if self.buckets.is_empty() {
                        self.min_val = 0;
                    } else {
                        self.min_val = self.buckets.keys().min().copied().unwrap_or(0);
                    }
                }
                if old_val == self.max_val && set.is_empty(){
                    self.max_val = self.buckets.keys().max().copied().unwrap_or(0);
                }
            }
        }

        if new_val > 0 {
            self.buckets.entry(new_val).or_insert(HashSet::new()).insert(key.clone());
            if self.min_val == 0 || new_val < self.min_val {
                self.min_val = new_val;
            }
        } else {
            self.map.remove(&key);
        }

        if self.max_val == old_val && self.buckets.get(&old_val).map_or(true, |s| s.is_empty()){
            self.max_val = self.buckets.keys().max().copied().unwrap_or(0);
        }
    }

    fn get_max_key(&self) -> String {
        if self.max_val == 0 {
            return "".to_string();
        }
        self.buckets.get(&self.max_val).and_then(|set| set.iter().next().map(|s| s.clone())).unwrap_or("".to_string())
    }

    fn get_min_key(&self) -> String {
        if self.min_val == 0 {
            return "".to_string();
        }
        self.buckets.get(&self.min_val).and_then(|set| set.iter().next().map(|s| s.clone())).unwrap_or("".to_string())
    }
}