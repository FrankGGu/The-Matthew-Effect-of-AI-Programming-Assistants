use rand::Rng;
use std::collections::HashMap;

struct Solution {
    nums: Vec<i32>,
    indices: HashMap<i32, Vec<usize>>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        let mut indices = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            indices.entry(num).or_insert(Vec::new()).push(i);
        }
        Solution { nums, indices }
    }

    fn pick(&self, target: i32) -> i32 {
        let indices = &self.indices[&target];
        let random_index = rand::thread_rng().gen_range(0..indices.len());
        indices[random_index] as i32
    }
}