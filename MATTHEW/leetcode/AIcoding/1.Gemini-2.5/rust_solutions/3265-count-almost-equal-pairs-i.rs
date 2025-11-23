use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs_i(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for num in nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut total_pairs = 0;
        for count in counts.values() {
            total_pairs += count * (count - 1) / 2;
        }
        total_pairs
    }
}