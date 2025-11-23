use rand::Rng;
use std::collections::{HashMap, HashSet};

struct Solution {
    map: HashMap<i32, i32>,
    m: i32,
}

impl Solution {
    fn new(n: i32, blacklist: Vec<i32>) -> Self {
        let mut blacklist_set: HashSet<i32> = blacklist.iter().cloned().collect();
        let m = n - blacklist.len() as i32;
        let mut map: HashMap<i32, i32> = HashMap::new();

        let mut last_valid_num = n - 1;

        for &b in blacklist.iter() {
            if b < m {
                while blacklist_set.contains(&last_valid_num) {
                    last_valid_num -= 1;
                }
                map.insert(b, last_valid_num);
                last_valid_num -= 1;
            }
        }

        Solution { map, m }
    }

    fn pick(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let r = rng.gen_range(0..self.m);

        *self.map.get(&r).unwrap_or(&r)
    }
}