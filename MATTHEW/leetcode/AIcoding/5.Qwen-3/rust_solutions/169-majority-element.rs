impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn majority_element(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut majority = nums[0];
        let mut max_count = 1;

        for &num in &nums {
            let c = count.entry(num).or_insert(0);
            *c += 1;
            if *c > max_count {
                max_count = *c;
                majority = num;
            }
        }

        majority
    }
}
}