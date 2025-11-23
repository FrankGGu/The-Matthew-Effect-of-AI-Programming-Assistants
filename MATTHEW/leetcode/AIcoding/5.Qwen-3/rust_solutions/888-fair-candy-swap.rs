impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn fair_candy_swap(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let sum_a: i32 = a.iter().sum();
        let sum_b: i32 = b.iter().sum();
        let diff = (sum_a - sum_b) / 2;

        let set_b: HashSet<i32> = b.into_iter().collect();

        for x in a {
            if set_b.contains(&(x - diff)) {
                return vec![x, x - diff];
            }
        }

        vec![]
    }
}
}