impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn contains_duplicate(nums: Vec<i32>, k: i32) -> bool {
        let mut seen = HashSet::new();
        for (i, &num) in nums.iter().enumerate() {
            if seen.contains(&num) {
                return true;
            }
            seen.insert(num);
            if seen.len() > k as usize {
                seen.remove(&nums[i - k as usize]);
            }
        }
        false
    }
}
}