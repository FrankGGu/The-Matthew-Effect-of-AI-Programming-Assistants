use std::collections::HashMap;

impl Solution {
    pub fn min_cost(basket1: Vec<i32>, basket2: Vec<i32>) -> i64 {
        let mut freq = HashMap::new();
        for &num in &basket1 {
            *freq.entry(num).or_insert(0) += 1;
        }
        for &num in &basket2 {
            *freq.entry(num).or_insert(0) -= 1;
        }

        let mut swaps = Vec::new();
        for (&num, &count) in &freq {
            if count % 2 != 0 {
                return -1;
            }
            let diff = count.abs() / 2;
            for _ in 0..diff {
                swaps.push(num);
            }
        }

        swaps.sort();
        let min_all = *freq.keys().min().unwrap();
        let mut res = 0;
        for i in 0..swaps.len() / 2 {
            res += std::cmp::min(swaps[i], 2 * min_all) as i64;
        }
        res
    }
}