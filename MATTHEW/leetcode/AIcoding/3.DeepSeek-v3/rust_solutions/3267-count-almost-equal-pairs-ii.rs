use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs(nums: Vec<i32>) -> i64 {
        let mut freq = HashMap::new();
        let mut res = 0;
        for &num in nums.iter() {
            res += freq.get(&(num - 1)).unwrap_or(&0);
            res += freq.get(&num).unwrap_or(&0);
            res += freq.get(&(num + 1)).unwrap_or(&0);
            *freq.entry(num).or_insert(0) += 1;
        }
        res
    }
}