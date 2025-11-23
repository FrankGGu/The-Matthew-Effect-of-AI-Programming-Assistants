use std::collections::HashMap;
use rand::Rng;

struct Solution {
    m: usize,
    map: HashMap<i32, i32>,
    rng: rand::rngs::ThreadRng,
}

impl Solution {
    fn new(n: i32, blacklist: Vec<i32>) -> Self {
        let m = (n - blacklist.len() as i32) as usize;
        let mut map = HashMap::new();
        let mut black = blacklist;
        black.sort();
        let mut j = 0;
        let mut k = n - 1;
        for &num in &black {
            if num >= m as i32 {
                continue;
            }
            while black.binary_search(&k).is_ok() {
                k -= 1;
            }
            map.insert(num, k);
            k -= 1;
        }
        Solution {
            m,
            map,
            rng: rand::thread_rng(),
        }
    }

    fn pick(&mut self) -> i32 {
        let r = self.rng.gen_range(0..self.m as i32);
        if let Some(&v) = self.map.get(&r) {
            v
        } else {
            r
        }
    }
}