use rand::Rng;
use std::collections::HashMap;

struct Solution {
    m: i32,
    n: i32,
    size: i32,
    map: HashMap<i32, i32>,
}

impl Solution {
    fn new(m: i32, n: i32) -> Self {
        Solution {
            m,
            n,
            size: m * n,
            map: HashMap::new(),
        }
    }

    fn flip(&mut self) -> Vec<i32> {
        let mut rng = rand::thread_rng();
        let r = rng.gen_range(0..self.size);
        self.size -= 1;

        let x = if self.map.contains_key(&r) {
            *self.map.get(&r).unwrap()
        } else {
            r
        };

        let y = if self.map.contains_key(&self.size) {
            *self.map.get(&self.size).unwrap()
        } else {
            self.size
        };

        self.map.insert(r, y);

        vec![x / self.n, x % self.n]
    }

    fn reset(&mut self) {
        self.size = self.m * self.n;
        self.map.clear();
    }
}