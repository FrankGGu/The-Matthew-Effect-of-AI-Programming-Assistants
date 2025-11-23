use std::collections::HashMap;

impl Solution {
    pub fn max_difference_frequency(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut max_even = -1;
        let mut min_odd = -1;

        for (_, &count) in freq.iter() {
            if count % 2 == 0 {
                if max_even == -1 || count > max_even {
                    max_even = count;
                }
            } else {
                if min_odd == -1 || count < min_odd {
                    min_odd = count;
                }
            }
        }

        if max_even == -1 || min_odd == -1 {
            -1
        } else {
            max_even - min_odd
        }
    }
}