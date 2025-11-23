use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(deliciousness: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut freq = HashMap::new();
        let modulo = 1_000_000_007;

        for &num in deliciousness.iter() {
            for power in 0..22 {
                let target = (1 << power) - num;
                if let Some(&c) = freq.get(&target) {
                    count = (count + c) % modulo;
                }
            }
            *freq.entry(num).or_insert(0) += 1;
        }

        count
    }
}