use std::collections::HashMap;

impl Solution {
    pub fn count_bad_pairs(nums: Vec<i32>) -> i64 {
        let n = nums.len() as i64;

        let total_pairs = n * (n - 1) / 2;

        let mut diff_counts: HashMap<i32, i64> = HashMap::new();

        for k in 0..nums.len() {
            let diff = nums[k] - k as i32;
            *diff_counts.entry(diff).or_insert(0) += 1;
        }

        let mut good_pairs = 0;
        for &count in diff_counts.values() {
            good_pairs += count * (count - 1) / 2;
        }

        total_pairs - good_pairs
    }
}