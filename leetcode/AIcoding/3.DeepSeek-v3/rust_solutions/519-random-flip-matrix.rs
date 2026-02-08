use rand::prelude::*;
use std::collections::HashMap;

struct Solution {
    rows: i32,
    cols: i32,
    total: i32,
    map: HashMap<i32, i32>,
    rng: ThreadRng,
}

impl Solution {
    fn new(m: i32, n: i32) -> Self {
        Solution {
            rows: m,
            cols: n,
            total: m * n,
            map: HashMap::new(),
            rng: thread_rng(),
        }
    }

    fn flip(&mut self) -> Vec<i32> {
        let r = self.rng.gen_range(0, self.total);
        self.total -= 1;
        let x = *self.map.get(&r).unwrap_or(&r);
        self.map.insert(r, *self.map.get(&self.total).unwrap_or(&self.total));
        vec![x / self.cols, x % self.cols]
    }

    fn reset(&mut self) {
        self.total = self.rows * self.cols;
        self.map.clear();
    }
}