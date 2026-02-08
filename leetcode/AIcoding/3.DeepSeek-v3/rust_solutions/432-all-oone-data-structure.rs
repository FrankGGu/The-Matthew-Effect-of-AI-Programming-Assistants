use std::collections::{HashMap, HashSet, LinkedList};

struct AllOne {
    key_to_value: HashMap<String, i32>,
    value_to_keys: HashMap<i32, HashSet<String>>,
    values: LinkedList<i32>,
}

impl AllOne {
    fn new() -> Self {
        AllOne {
            key_to_value: HashMap::new(),
            value_to_keys: HashMap::new(),
            values: LinkedList::new(),
        }
    }

    fn inc(&mut self, key: String) {
        let value = self.key_to_value.entry(key.clone()).or_insert(0);
        if *value > 0 {
            self.value_to_keys.get_mut(value).unwrap().remove(&key);
        }
        *value += 1;
        self.value_to_keys.entry(*value).or_insert_with(HashSet::new).insert(key);
        if self.values.is_empty() || *value > *self.values.back().unwrap() {
            self.values.push_back(*value);
        }
    }

    fn dec(&mut self, key: String) {
        if let Some(value) = self.key_to_value.get_mut(&key) {
            self.value_to_keys.get_mut(value).unwrap().remove(&key);
            *value -= 1;
            if *value > 0 {
                self.value_to_keys.entry(*value).or_insert_with(HashSet::new).insert(key);
            } else {
                self.key_to_value.remove(&key);
            }
            if *value < *self.values.front().unwrap() {
                self.values.push_front(*value);
            }
        }
    }

    fn get_max_key(&self) -> String {
        if let Some(max_value) = self.values.back() {
            if let Some(keys) = self.value_to_keys.get(max_value) {
                if let Some(key) = keys.iter().next() {
                    return key.clone();
                }
            }
        }
        String::new()
    }

    fn get_min_key(&self) -> String {
        if let Some(min_value) = self.values.front() {
            if let Some(keys) = self.value_to_keys.get(min_value) {
                if let Some(key) = keys.iter().next() {
                    return key.clone();
                }
            }
        }
        String::new()
    }
}