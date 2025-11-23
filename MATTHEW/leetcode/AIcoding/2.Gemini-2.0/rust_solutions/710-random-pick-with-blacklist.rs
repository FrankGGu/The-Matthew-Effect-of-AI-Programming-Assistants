use rand::Rng;
use std::collections::HashMap;

struct Solution {
    size: i32,
    map: HashMap<i32, i32>,
}

impl Solution {
    fn new(n: i32, blacklist: Vec<i32>) -> Self {
        let mut map = HashMap::new();
        let mut size = n - blacklist.len() as i32;

        let mut blacklist_set = std::collections::HashSet::new();
        for &b in &blacklist {
            blacklist_set.insert(b);
        }

        for &b in &blacklist {
            if b < size {
                while blacklist_set.contains(&size) {
                    size += 1;
                }
                map.insert(b, size);
                size += 1;
            }
        }

        Solution {
            size: n - blacklist.len() as i32,
            map,
        }
    }

    fn pick(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let index = rng.gen_range(0..self.size);
        match self.map.get(&index) {
            Some(&val) => val,
            None => index,
        }
    }
}