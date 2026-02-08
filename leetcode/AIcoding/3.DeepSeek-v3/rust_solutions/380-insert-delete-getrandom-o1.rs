use std::collections::HashMap;
use rand::Rng;

struct RandomizedSet {
    map: HashMap<i32, usize>,
    vec: Vec<i32>,
}

impl RandomizedSet {
    fn new() -> Self {
        RandomizedSet {
            map: HashMap::new(),
            vec: Vec::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        if self.map.contains_key(&val) {
            return false;
        }
        self.map.insert(val, self.vec.len());
        self.vec.push(val);
        true
    }

    fn remove(&mut self, val: i32) -> bool {
        if let Some(&index) = self.map.get(&val) {
            let last = *self.vec.last().unwrap();
            self.vec[index] = last;
            self.map.insert(last, index);
            self.vec.pop();
            self.map.remove(&val);
            true
        } else {
            false
        }
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let index = rng.gen_range(0..self.vec.len());
        self.vec[index]
    }
}