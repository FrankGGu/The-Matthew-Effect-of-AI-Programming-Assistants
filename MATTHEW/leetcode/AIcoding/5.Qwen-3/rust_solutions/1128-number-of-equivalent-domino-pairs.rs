impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_equiv_domino_pairs(dominoes: Vec<Vec<i32>>) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;

        for d in dominoes {
            let (a, b) = if d[0] <= d[1] { (d[0], d[1]) } else { (d[1], d[0]) };
            let key = (a, b);
            *count.entry(key).or_insert(0) += 1;
        }

        for v in count.values() {
            if *v >= 2 {
                result += v * (v - 1) / 2;
            }
        }

        result
    }
}
}