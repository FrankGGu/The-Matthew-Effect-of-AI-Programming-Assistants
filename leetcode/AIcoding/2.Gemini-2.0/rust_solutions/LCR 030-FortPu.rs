use rand::Rng;
use std::collections::HashMap;

struct RandomizedSet {
    nums: Vec<i32>,
    indices: HashMap<i32, usize>,
}

impl RandomizedSet {
    fn new() -> Self {
        RandomizedSet {
            nums: Vec::new(),
            indices: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        if self.indices.contains_key(&val) {
            return false;
        }

        self.nums.push(val);
        self.indices.insert(val, self.nums.len() - 1);
        true
    }

    fn remove(&mut self, val: i32) -> bool {
        if !self.indices.contains_key(&val) {
            return false;
        }

        let index = self.indices[&val];
        let last_val = self.nums[self.nums.len() - 1];

        self.nums[index] = last_val;
        self.indices.insert(last_val, index);

        self.nums.pop();
        self.indices.remove(&val);

        true
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let index = rng.gen_range(0..self.nums.len());
        self.nums[index]
    }
}