impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn find_largest_almost_missing(nums: Vec<i32>) -> i32 {
        let mut set: HashSet<i32> = nums.iter().cloned().collect();
        let mut max_val = nums.iter().max().copied().unwrap_or(0);

        for i in (1..=max_val).rev() {
            if !set.contains(&i) {
                return i;
            }
        }

        max_val + 1
    }
}
}