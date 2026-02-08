use rand::Rng;
use std::collections::HashMap;

struct Solution {
    n: i32,
    blacklist: HashMap<i32, i32>,
}

impl Solution {
    fn new(n: i32, blacklist: Vec<i32>) -> Self {
        let mut blacklist_map = HashMap::new();
        let mut b_set: HashSet<i32> = HashSet::new();
        for &b in &blacklist {
            b_set.insert(b);
        }
        let mut last = n - 1;
        for &b in &blacklist {
            if b >= n {
                continue;
            }
            while b_set.contains(&last) {
                last -= 1;
            }
            blacklist_map.insert(b, last);
            last -= 1;
        }
        Solution { n, blacklist: blacklist_map }
    }

    fn pick(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let rand_num = rng.gen_range(0..self.n);
        if let Some(&mapped) = self.blacklist.get(&rand_num) {
            mapped
        } else {
            rand_num
        }
    }
}