impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_good_pairs(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;

        for num in nums {
            let c = count.entry(num).or_insert(0);
            result += *c;
            *c += 1;
        }

        result
    }
}
}