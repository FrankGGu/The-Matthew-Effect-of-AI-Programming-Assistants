impl Solution {

use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn min_stalls(people: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        for &p in &people {
            *map.entry(p).or_insert(0) += 1;
        }
        let mut set = HashSet::new();
        for &p in &people {
            set.insert(p);
        }
        let mut result = 0;
        for &p in &set {
            if map[&p] > 1 {
                result += 1;
            }
        }
        result
    }
}
}