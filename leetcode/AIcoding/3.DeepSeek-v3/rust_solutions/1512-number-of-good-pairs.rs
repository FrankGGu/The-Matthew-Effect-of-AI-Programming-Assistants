use std::collections::HashMap;

impl Solution {
    pub fn num_identical_pairs(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut res = 0;
        for num in nums {
            let c = count.entry(num).or_insert(0);
            res += *c;
            *c += 1;
        }
        res
    }
}