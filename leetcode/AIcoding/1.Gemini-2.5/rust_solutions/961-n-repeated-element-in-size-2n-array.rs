use std::collections::HashSet;

impl Solution {
    pub fn repeated_n_times(nums: Vec<i32>) -> i32 {
        let mut seen = HashSet::new();
        for num in nums {
            if !seen.insert(num) {
                return num;
            }
        }
        unreachable!()
    }
}