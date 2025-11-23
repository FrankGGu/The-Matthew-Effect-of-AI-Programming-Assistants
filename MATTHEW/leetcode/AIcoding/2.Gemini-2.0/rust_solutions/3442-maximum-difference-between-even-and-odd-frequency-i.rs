use std::collections::HashMap;

impl Solution {
    pub fn max_frequency_difference(nums: Vec<i32>) -> i32 {
        let mut even_freq: HashMap<i32, i32> = HashMap::new();
        let mut odd_freq: HashMap<i32, i32> = HashMap::new();

        for &num in &nums {
            if num % 2 == 0 {
                *even_freq.entry(num).or_insert(0) += 1;
            } else {
                *odd_freq.entry(num).or_insert(0) += 1;
            }
        }

        let mut max_even = i32::MIN;
        let mut min_odd = i32::MAX;

        if even_freq.is_empty() {
            max_even = 0;
        } else {
            for (_, &freq) in &even_freq {
                max_even = max_even.max(freq);
            }
        }

        if odd_freq.is_empty() {
            min_odd = 0;
        } else {
            for (_, &freq) in &odd_freq {
                min_odd = min_odd.min(freq);
            }
        }

        max_even - min_odd
    }
}