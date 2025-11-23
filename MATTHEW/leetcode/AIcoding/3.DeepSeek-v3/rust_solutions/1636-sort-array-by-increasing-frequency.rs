use std::collections::HashMap;

impl Solution {
    pub fn frequency_sort(nums: Vec<i32>) -> Vec<i32> {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let mut nums = nums;
        nums.sort_by(|a, b| {
            let freq_a = freq.get(a).unwrap();
            let freq_b = freq.get(b).unwrap();
            if freq_a == freq_b {
                b.cmp(a)
            } else {
                freq_a.cmp(freq_b)
            }
        });
        nums
    }
}