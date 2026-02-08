use rand::Rng;
use std::collections::HashMap;

struct RandomizedCollection {
    nums: Vec<i32>,
    idx: HashMap<i32, Vec<usize>>,
}

impl RandomizedCollection {
    fn new() -> Self {
        RandomizedCollection {
            nums: Vec::new(),
            idx: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        self.nums.push(val);
        let index = self.nums.len() - 1;
        self.idx.entry(val).or_insert(Vec::new()).push(index);
        self.idx[&val].len() == 1
    }

    fn remove(&mut self, val: i32) -> bool {
        if !self.idx.contains_key(&val) || self.idx[&val].is_empty() {
            return false;
        }

        let remove_index = self.idx.get_mut(&val).unwrap().pop().unwrap();
        let last_element = self.nums.last().unwrap();
        let last_index = self.nums.len() - 1;

        if remove_index != last_index {
            self.nums.swap(remove_index, last_index);

            let indices = self.idx.get_mut(last_element).unwrap();
            if let Some(pos) = indices.iter().position(|&x| x == last_index) {
                indices[pos] = remove_index;
            }
        }

        self.nums.pop();
        true
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let index = rng.gen_range(0..self.nums.len());
        self.nums[index]
    }
}