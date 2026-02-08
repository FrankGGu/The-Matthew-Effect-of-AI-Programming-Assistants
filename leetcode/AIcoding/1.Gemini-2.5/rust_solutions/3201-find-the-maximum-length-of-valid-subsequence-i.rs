use std::collections::{HashMap, HashSet};
use std::cmp::max;

impl Solution {
    pub fn maximum_length(nums: Vec<i32>) -> i32 {
        let mut freq_map: HashMap<i32, usize> = HashMap::new();
        let mut max_freq: usize = 0;

        for &num in &nums {
            *freq_map.entry(num).or_insert(0) += 1;
            max_freq = max(max_freq, *freq_map.get(&num).unwrap());
        }

        let mut distinct_elements: HashSet<i32> = HashSet::new();
        for &num in &nums {
            distinct_elements.insert(num);
        }
        let distinct_count: usize = distinct_elements.len();

        max(max_freq, distinct_count) as i32
    }
}