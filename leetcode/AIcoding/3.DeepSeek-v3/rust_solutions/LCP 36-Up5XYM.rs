use std::collections::HashMap;

impl Solution {
    pub fn max_groups(mut cards: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &cards {
            *count.entry(num).or_insert(0) += 1;
        }
        let mut freq: Vec<i32> = count.values().cloned().collect();
        freq.sort_unstable();

        let mut res = 0;
        let mut prev = 0;
        for &f in &freq {
            if f > prev {
                res += 1;
                prev = f;
            } else {
                res += f;
                prev = f;
            }
        }
        res
    }
}