use std::collections::HashMap;

impl Solution {
    pub fn num_equiv_domino_pairs(dominoes: Vec<Vec<i32>>) -> i32 {
        let mut count = HashMap::new();
        let mut pairs = 0;

        for domino in dominoes {
            let mut sorted = domino.clone();
            sorted.sort();
            *count.entry((sorted[0], sorted[1])).or_insert(0) += 1;
        }

        for &value in count.values() {
            pairs += value * (value - 1) / 2;
        }

        pairs
    }
}