impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn even_odd_difference(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut even_sum = 0;
        let mut odd_sum = 0;

        for (&num, &count) in &freq {
            if count % 2 == 0 {
                even_sum += num * count;
            } else {
                odd_sum += num * count;
            }
        }

        even_sum - odd_sum
    }
}
}