use std::collections::HashMap;

impl Solution {
    pub fn count_interesting_subarrays(nums: Vec<i32>, modulo: i32, k: i32) -> i64 {
        let mut prefix_counts = HashMap::new();
        prefix_counts.insert(0, 1);
        let mut count = 0;
        let mut prefix = 0;
        let mut res = 0i64;

        for num in nums {
            if num % modulo == k {
                prefix += 1;
            }
            let key = prefix % modulo;
            let target = (key - k).rem_euclid(modulo);
            res += *prefix_counts.get(&target).unwrap_or(&0);
            *prefix_counts.entry(key).or_insert(0) += 1;
        }

        res
    }
}