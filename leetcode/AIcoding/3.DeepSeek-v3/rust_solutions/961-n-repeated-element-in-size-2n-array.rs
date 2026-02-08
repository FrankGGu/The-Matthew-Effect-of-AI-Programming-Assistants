use std::collections::HashSet;

impl Solution {
    pub fn repeated_n_times(nums: Vec<i32>) -> i32 {
        let mut seen = HashSet::new();
        for &num in nums.iter() {
            if seen.contains(&num) {
                return num;
            }
            seen.insert(num);
        }
        -1
    }
}