use std::collections::HashMap;

impl Solution {
    pub fn min_array_length(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        let n = nums.len() as i32;

        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut max_freq = 0;
        for &freq in counts.values() {
            if freq > max_freq {
                max_freq = freq;
            }
        }

        if max_freq * 2 > n {
            max_freq * 2 - n
        } else {
            n % 2
        }
    }
}