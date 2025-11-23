use std::collections::HashMap;
use rand::Rng;

struct RandomizedSet {
    vals: Vec<i32>,
    indices: HashMap<i32, usize>,
}

impl RandomizedSet {
    fn new() -> Self {
        RandomizedSet {
            vals: Vec::new(),
            indices: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        if self.indices.contains_key(&val) {
            return false;
        }

        self.indices.insert(val, self.vals.len());
        self.vals.push(val);
        true
    }

    fn remove(&mut self, val: i32) -> bool {
        if !self.indices.contains_key(&val) {
            return false;
        }

        let index_to_remove = *self.indices.get(&val).unwrap();
        let last_element_val = *self.vals.last().unwrap();

        if index_to_remove != self.vals.len() - 1 {
            self.vals[index_to_remove] = last_element_val;
            self.indices.insert(last_element_val, index_to_remove);
        }

        self.indices.remove(&val);
        self.vals.pop();

        true
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let random_index = rng.gen_range(0..self.vals.len());
        self.vals[random_index]
    }
}