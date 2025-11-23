use std::collections::HashMap;

impl Solution {
    pub fn max_difference_frequency(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut even_max = i32::MIN;
        let mut odd_min = i32::MAX;
        let mut has_even = false;
        let mut has_odd = false;

        for &count in freq.values() {
            if count % 2 == 0 {
                has_even = true;
                if count > even_max {
                    even_max = count;
                }
            } else {
                has_odd = true;
                if count < odd_min {
                    odd_min = count;
                }
            }
        }

        if !has_even || !has_odd {
            return 0;
        }

        even_max - odd_min
    }
}