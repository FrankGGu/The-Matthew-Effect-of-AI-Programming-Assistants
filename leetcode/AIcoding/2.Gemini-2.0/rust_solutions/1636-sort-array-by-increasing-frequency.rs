use std::collections::HashMap;

impl Solution {
    pub fn frequency_sort(nums: Vec<i32>) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut sorted_nums = nums.clone();
        sorted_nums.sort_by(|a, b| {
            let count_a = counts.get(a).unwrap();
            let count_b = counts.get(b).unwrap();
            if count_a == count_b {
                b.cmp(a)
            } else {
                count_a.cmp(count_b)
            }
        });

        sorted_nums
    }
}