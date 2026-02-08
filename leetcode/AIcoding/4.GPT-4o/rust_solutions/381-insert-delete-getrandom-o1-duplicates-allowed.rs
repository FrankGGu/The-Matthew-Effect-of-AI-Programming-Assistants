use std::collections::HashMap;
use rand::Rng;

struct RandomizedCollection {
    nums: Vec<i32>,
    indices: HashMap<i32, Vec<usize>>,
}

impl RandomizedCollection {
    fn new() -> Self {
        RandomizedCollection {
            nums: Vec::new(),
            indices: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        let contains = self.indices.contains_key(&val);
        self.nums.push(val);
        self.indices.entry(val).or_insert_with(Vec::new).push(self.nums.len() - 1);
        !contains
    }

    fn remove(&mut self, val: i32) -> bool {
        if let Some(pos_vec) = self.indices.get_mut(&val) {
            let last_index = self.nums.len() - 1;
            let remove_index = pos_vec.pop().unwrap();
            if remove_index != last_index {
                self.nums.swap(remove_index, last_index);
                if let Some(indices) = self.indices.get_mut(&self.nums[remove_index]) {
                    indices.retain(|&x| x != last_index);
                    indices.push(remove_index);
                }
            }
            self.nums.pop();
            if pos_vec.is_empty() {
                self.indices.remove(&val);
            }
            return true;
        }
        false
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        self.nums[rng.gen_range(0..self.nums.len())]
    }
}