use std::collections::HashSet;

impl Solution {
    pub fn fair_candy_swap(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let sum_a: i32 = a.iter().sum();
        let sum_b: i32 = b.iter().sum();
        let diff = (sum_b - sum_a) / 2;
        let set_b: HashSet<_> = b.into_iter().collect();

        for x in a {
            let y = x + diff;
            if set_b.contains(&y) {
                return vec![x, y];
            }
        }

        vec![]
    }
}