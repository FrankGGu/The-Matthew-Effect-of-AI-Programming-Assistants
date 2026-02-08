use std::collections::HashSet;

impl Solution {
    pub fn largest_almost_missing(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let s: HashSet<i32> = nums.into_iter().collect();
        for i in (1..=n as i32 + 2).rev() {
            if !s.contains(&i) {
                return i;
            }
        }
        0
    }
}