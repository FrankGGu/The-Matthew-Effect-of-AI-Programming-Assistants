use std::collections::HashMap;

impl Solution {
    pub fn num_good_pairs(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for num in nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut good_pairs = 0;
        for (_num, count) in counts {
            if count >= 2 {
                good_pairs += count * (count - 1) / 2;
            }
        }
        good_pairs
    }
}