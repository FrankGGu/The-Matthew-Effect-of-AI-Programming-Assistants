use std::collections::HashMap;
use std::collections::HashSet;
use rand::prelude::*;

struct RandomizedCollection {
    index_map: HashMap<i32, HashSet<usize>>,
    values: Vec<i32>,
}

impl RandomizedCollection {
    fn new() -> Self {
        RandomizedCollection {
            index_map: HashMap::new(),
            values: Vec::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        let contains = !self.index_map.contains_key(&val);
        let entry = self.index_map.entry(val).or_insert(HashSet::new());
        entry.insert(self.values.len());
        self.values.push(val);
        contains
    }

    fn remove(&mut self, val: i32) -> bool {
        if let Some(indices) = self.index_map.get_mut(&val) {
            if let Some(&index) = indices.iter().next() {
                indices.remove(&index);
                if indices.is_empty() {
                    self.index_map.remove(&val);
                }
                let last_index = self.values.len() - 1;
                if index != last_index {
                    let last_val = self.values[last_index];
                    self.values.swap(index, last_index);
                    if let Some(indices) = self.index_map.get_mut(&last_val) {
                        indices.remove(&last_index);
                        indices.insert(index);
                    }
                }
                self.values.pop();
                return true;
            }
        }
        false
    }

    fn get_random(&self) -> i32 {
        let mut rng = thread_rng();
        let index = rng.gen_range(0..self.values.len());
        self.values[index]
    }
}