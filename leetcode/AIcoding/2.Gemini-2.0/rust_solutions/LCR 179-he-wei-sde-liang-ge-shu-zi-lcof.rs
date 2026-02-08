use std::collections::HashSet;

impl Solution {
    pub fn two_sum(price: Vec<i32>, target: i32) -> Vec<i32> {
        let mut seen = HashSet::new();
        for &p in &price {
            let complement = target - p;
            if seen.contains(&complement) {
                return vec![complement, p];
            }
            seen.insert(p);
        }
        vec![]
    }
}