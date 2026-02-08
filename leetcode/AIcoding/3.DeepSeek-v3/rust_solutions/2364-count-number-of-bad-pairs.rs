use std::collections::HashMap;

impl Solution {
    pub fn count_bad_pairs(nums: Vec<i32>) -> i64 {
        let mut count = 0;
        let mut freq = HashMap::new();
        let n = nums.len() as i64;
        let total_pairs = n * (n - 1) / 2;

        for (i, &num) in nums.iter().enumerate() {
            let key = num - i as i32;
            let good_pairs = *freq.get(&key).unwrap_or(&0);
            count += good_pairs;
            *freq.entry(key).or_insert(0) += 1;
        }

        total_pairs - count
    }
}