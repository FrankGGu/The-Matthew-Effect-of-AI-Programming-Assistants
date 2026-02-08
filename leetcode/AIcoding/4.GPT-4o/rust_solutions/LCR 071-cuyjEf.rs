use rand::Rng;

struct Solution {
    weights: Vec<i32>,
    prefix_sum: Vec<i32>,
}

impl Solution {
    fn new(w: Vec<i32>) -> Self {
        let mut prefix_sum = vec![0; w.len()];
        prefix_sum[0] = w[0];
        for i in 1..w.len() {
            prefix_sum[i] = prefix_sum[i - 1] + w[i];
        }
        Solution { weights: w, prefix_sum }
    }

    fn pick_index(&self) -> i32 {
        let total_weight = self.prefix_sum.last().unwrap();
        let target = rand::thread_rng().gen_range(1..=*total_weight);
        self.prefix_sum.binary_search(&target).unwrap_or_else(|x| x) as i32
    }
}