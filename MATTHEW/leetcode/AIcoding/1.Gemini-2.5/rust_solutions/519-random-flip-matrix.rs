use rand::Rng;
use std::collections::HashMap;

struct Solution {
    m: i32,
    n: i32,
    total_cells: i32,
    count: i32,
    map: HashMap<i32, i32>,
    rng: rand::rngs::ThreadRng,
}

impl Solution {
    fn new(m: i32, n: i32) -> Self {
        let total_cells = m * n;
        Solution {
            m,
            n,
            total_cells,
            count: total_cells,
            map: HashMap::new(),
            rng: rand::thread_rng(),
        }
    }

    fn flip(&mut self) -> Vec<i32> {
        let idx = self.rng.gen_range(0..self.count);

        let chosen_1d_idx = *self.map.get(&idx).unwrap_or(&idx);
        let last_1d_idx = *self.map.get(&(self.count - 1)).unwrap_or(&(self.count - 1));

        self.map.insert(idx, last_1d_idx);
        self.count -= 1;

        vec![chosen_1d_idx / self.n, chosen_1d_idx % self.n]
    }

    fn reset(&mut self) {
        self.map.clear();
        self.count = self.total_cells;
    }
}