use std::collections::HashMap;

impl Solution {
    pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut frequency_map = HashMap::new();
        for &num in &nums {
            *frequency_map.entry(num).or_insert(0) += 1;
        }

        let mut frequency_vec: Vec<(i32, i32)> = frequency_map.into_iter().collect();
        frequency_vec.sort_by(|a, b| b.1.cmp(&a.1));

        frequency_vec.into_iter().take(k as usize).map(|(num, _)| num).collect()
    }
}