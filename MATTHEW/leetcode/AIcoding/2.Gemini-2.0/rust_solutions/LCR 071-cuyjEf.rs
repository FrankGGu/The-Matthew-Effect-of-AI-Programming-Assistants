use rand::Rng;

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

        let mut low = 0;
        let mut high = self.prefix_sums.len() as i32 - 1;

        while low <= high {
            let mid = low + (high - low) / 2;
            if self.prefix_sums[mid as usize] < target {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        low
    }
}