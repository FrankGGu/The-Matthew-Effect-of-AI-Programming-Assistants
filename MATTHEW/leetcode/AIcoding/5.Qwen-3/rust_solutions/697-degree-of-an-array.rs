impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_shortest_subarray(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut first_occurrence = HashMap::new();
        let mut last_occurrence = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            let count = freq.entry(num).or_insert(0);
            *count += 1;
            if !first_occurrence.contains_key(&num) {
                first_occurrence.insert(num, i);
            }
            last_occurrence.insert(num, i);
        }

        let mut min_length = nums.len() as i32;
        let max_freq = freq.values().max().copied().unwrap_or(0);

        for (num, &count) in &freq {
            if *count == max_freq {
                let length = last_occurrence[num] - first_occurrence[num] + 1;
                min_length = std::cmp::min(min_length, length as i32);
            }
        }

        min_length
    }
}
}