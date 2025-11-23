use rand::Rng;
use std::collections::HashMap;

struct RandomizedSet {
    nums: Vec<i32>,
    idx: HashMap<i32, usize>,
}

impl RandomizedSet {
    fn new() -> Self {
        RandomizedSet {
            nums: Vec::new(),
            idx: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        if self.idx.contains_key(&val) {
            return false;
        }
        self.nums.push(val);
        self.idx.insert(val, self.nums.len() - 1);
        true
    }

    fn remove(&mut self, val: i32) -> bool {
        if !self.idx.contains_key(&val) {
            return false;
        }
        let index = *self.idx.get(&val).unwrap();
        let last = self.nums.last().unwrap();
        self.nums.swap_remove(index);
        self.idx.remove(&val);

        if index < self.nums.len() {
            self.nums.swap(index, self.nums.len());
            self.idx.insert(*last, index);
            self.nums.pop();
        }
        true
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let index = rng.gen_range(0..self.nums.len());
        self.nums[index]
    }
}