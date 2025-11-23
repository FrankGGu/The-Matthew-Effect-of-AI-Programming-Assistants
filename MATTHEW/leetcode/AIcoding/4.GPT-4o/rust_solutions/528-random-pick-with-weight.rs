use rand::Rng;

struct Solution {
    weights: Vec<i32>,
    prefix_sums: Vec<i32>,
}

impl Solution {
    fn new(w: Vec<i32>) -> Self {
        let mut prefix_sums = Vec::new();
        let mut total = 0;
        for &weight in &w {
            total += weight;
            prefix_sums.push(total);
        }
        Solution { weights: w, prefix_sums }
    }

    fn pick_index(&self) -> i32 {
        let total_weight = *self.prefix_sums.last().unwrap();
        let target = rand::thread_rng().gen_range(0..total_weight);
        self.prefix_sums.iter().position(|&x| x > target).unwrap() as i32
    }
}