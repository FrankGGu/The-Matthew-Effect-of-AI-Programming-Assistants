use rand::Rng;
use rand::rngs::ThreadRng;

struct Solution {
    prefix_sums: Vec<i32>,
    total_sum: i32,
    rng: ThreadRng,
}

impl Solution {
    fn new(w: Vec<i32>) -> Self {
        let mut prefix_sums = Vec::with_capacity(w.len());
        let mut current_sum = 0;
        for weight in w {
            current_sum += weight;
            prefix_sums.push(current_sum);
        }
        let total_sum = *prefix_sums.last().unwrap_or(&0);

        Solution {
            prefix_sums,
            total_sum,
            rng: rand::thread_rng(),
        }
    }

    fn pick_index(&mut self) -> i32 {
        let target = self.rng.gen_range(1..=self.total_sum);

        match self.prefix_sums.binary_search(&target) {
            Ok(idx) => idx as i32,
            Err(idx) => idx as i32,
        }
    }
}