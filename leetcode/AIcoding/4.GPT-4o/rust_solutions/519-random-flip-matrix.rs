use rand::Rng;
use std::collections::HashMap;

struct Solution {
    m: i32,
    n: i32,
    total: i32,
    map: HashMap<i32, i32>,
}

impl Solution {
    fn new(m: i32, n: i32) -> Self {
        Solution {
            m,
            n,
            total: m * n,
            map: HashMap::new(),
        }
    }

    fn flip(&mut self) -> Vec<i32> {
        let mut rng = rand::thread_rng();
        let idx = rng.gen_range(0..self.total);
        self.total -= 1;

        let x = self.map.entry(idx).or_insert(idx);
        let res = if let Some(&v) = self.map.get(&(self.total)) {
            *x = v;
            v
        } else {
            *x
        };

        let row = res / self.n;
        let col = res % self.n;
        self.map.insert(res, *x);
        vec![row, col]
    }

    fn reset(&mut self) {
        self.total = self.m * self.n;
        self.map.clear();
    }
}