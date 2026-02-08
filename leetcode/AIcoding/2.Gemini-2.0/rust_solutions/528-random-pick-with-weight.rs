use rand::prelude::*;

struct Solution {
    prefix_sums: Vec<i32>,
    total_sum: i32,
}

impl Solution {
    fn new(w: Vec<i32>) -> Self {
        let mut prefix_sums = Vec::with_capacity(w.len());
        let mut current_sum = 0;
        for &weight in &w {
            current_sum += weight;
            prefix_sums.push(current_sum);
        }
        Solution {
            prefix_sums,
            total_sum: current_sum,
        }
    }

    fn pick_index(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let target = rng.gen_range(1..=self.total_sum);
        match self.prefix_sums.binary_search(&target) {
            Ok(index) => index as i32,
            Err(index) => index as i32,
        }
    }
}