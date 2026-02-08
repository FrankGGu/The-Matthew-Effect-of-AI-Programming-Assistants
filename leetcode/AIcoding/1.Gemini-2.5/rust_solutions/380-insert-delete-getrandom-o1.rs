use std::collections::HashMap;
use rand::Rng;

struct RandomizedSet {
    vec: Vec<i32>,
    map: HashMap<i32, usize>,
}

impl RandomizedSet {
    fn new() -> Self {
        RandomizedSet {
            vec: Vec::new(),
            map: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        if self.map.contains_key(&val) {
            false
        } else {
            self.map.insert(val, self.vec.len());
            self.vec.push(val);
            true
        }
    }

    fn remove(&mut self, val: i32) -> bool {
        if let Some(&idx) = self.map.get(&val) {
            let last_val = *self.vec.last().unwrap();

            self.vec[idx] = last_val;
            self.map.insert(last_val, idx);

            self.map.remove(&val);
            self.vec.pop();
            true
        } else {
            false
        }
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let random_index = rng.gen_range(0..self.vec.len());
        self.vec[random_index]
    }
}