use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_even(nums: Vec<i32>) -> i32 {
        let mut frequency = HashMap::new();
        for &num in nums.iter() {
            if num % 2 == 0 {
                *frequency.entry(num).or_insert(0) += 1;
            }
        }

        if frequency.is_empty() {
            return -1;
        }

        let mut max_freq = -1;
        let mut result = i32::MAX;
        for (num, &count) in frequency.iter() {
            if count > max_freq || (count == max_freq && *num < result) {
                max_freq = count;
                result = *num;
            }
        }

        result
    }
}