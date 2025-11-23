impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn arithmetic_triplets(nums: Vec<i32>, target: i32) -> i32 {
        let set: HashSet<i32> = nums.iter().cloned().collect();
        let mut count = 0;
        for &num in &nums {
            if set.contains(&(num + target)) && set.contains(&(num + 2 * target)) {
                count += 1;
            }
        }
        count
    }
}
}