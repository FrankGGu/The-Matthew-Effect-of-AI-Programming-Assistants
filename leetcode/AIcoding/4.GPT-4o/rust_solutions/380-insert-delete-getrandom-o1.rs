use std::collections::HashMap;
use rand::Rng;

struct RandomizedSet {
    nums: Vec<i32>,
    idx_map: HashMap<i32, usize>,
}

impl RandomizedSet {

    fn new() -> Self {
        RandomizedSet {
            nums: Vec::new(),
            idx_map: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        if self.idx_map.contains_key(&val) {
            return false;
        }
        self.nums.push(val);
        self.idx_map.insert(val, self.nums.len() - 1);
        true
    }

    fn remove(&mut self, val: i32) -> bool {
        if let Some(&idx) = self.idx_map.get(&val) {
            let last = self.nums.pop().unwrap();
            if idx < self.nums.len() {
                self.nums[idx] = last;
                self.idx_map.insert(last, idx);
            }
            self.idx_map.remove(&val);
            return true;
        }
        false
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let idx = rng.gen_range(0..self.nums.len());
        self.nums[idx]
    }
}