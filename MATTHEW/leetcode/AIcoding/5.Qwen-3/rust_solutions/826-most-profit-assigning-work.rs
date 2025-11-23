impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn max_profit_assign(works: Vec<i32>, profits: Vec<i32>, workers: Vec<i32>) -> i32 {
        let mut sorted = std::collections::BTreeSet::new();
        for &w in &works {
            sorted.insert(w);
        }
        let sorted_works: Vec<_> = sorted.into_iter().collect();

        let mut profit_map = std::collections::HashMap::new();
        for (&w, &p) in works.iter().zip(profits.iter()) {
            if !profit_map.contains_key(&w) || p > *profit_map.get(&w).unwrap() {
                profit_map.insert(w, p);
            }
        }

        let mut sorted_profit = vec![];
        for &w in &sorted_works {
            sorted_profit.push(*profit_map.get(&w).unwrap());
        }

        for i in 1..sorted_profit.len() {
            sorted_profit[i] = sorted_profit[i].max(sorted_profit[i - 1]);
        }

        let mut result = 0;
        for &w in &workers {
            let idx = match sorted_works.binary_search(&w) {
                Ok(i) => i,
                Err(i) => i - 1,
            };
            if idx >= 0 {
                result += sorted_profit[idx];
            }
        }

        result
    }
}
}