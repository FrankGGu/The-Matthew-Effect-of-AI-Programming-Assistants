use std::collections::HashMap;

impl Solution {
    pub fn count_k_difference(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        let mut count = 0;
        for &num in nums.iter() {
            count += freq.get(&(num + k)).unwrap_or(&0);
            count += freq.get(&(num - k)).unwrap_or(&0);
            *freq.entry(num).or_insert(0) += 1;
        }
        count
    }
}