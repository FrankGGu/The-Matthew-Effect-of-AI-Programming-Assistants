use std::collections::{HashMap, HashSet};
use rand::Rng;

struct RandomizedCollection {
    nums: Vec<i32>,
    val_to_indices: HashMap<i32, HashSet<usize>>,
    rng: rand::rngs::ThreadRng,
}

impl RandomizedCollection {
    fn new() -> Self {
        RandomizedCollection {
            nums: Vec::new(),
            val_to_indices: HashMap::new(),
            rng: rand::thread_rng(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        let was_present = self.val_to_indices.contains_key(&val);

        let new_idx = self.nums.len();
        self.nums.push(val);

        self.val_to_indices.entry(val).or_default().insert(new_idx);

        !was_present
    }

    fn remove(&mut self, val: i32) -> bool {
        let Some(indices_set) = self.val_to_indices.get_mut(&val) else {
            return false;
        };
        if indices_set.is_empty() {
            return false;
        }

        let idx_to_remove = *indices_set.iter().next().unwrap();
        indices_set.remove(&idx_to_remove);

        let last_idx = self.nums.len() - 1;
        let last_val = self.nums[last_idx];

        if idx_to_remove != last_idx {
            self.nums[idx_to_remove] = last_val;

            let last_val_indices = self.val_to_indices.get_mut(&last_val).unwrap();
            last_val_indices.remove(&last_idx);
            last_val_indices.insert(idx_to_remove);
        }

        self.nums.pop();

        if indices_set.is_empty() {
            self.val_to_indices.remove(&val);
        }

        true
    }

    fn get_random(&mut self) -> i32 {
        let random_idx = self.rng.gen_range(0..self.nums.len());
        self.nums[random_idx]
    }
}