use std::collections::HashSet;

impl Solution {
    pub fn is_possible_to_split(nums: Vec<i32>) -> bool {
        let mut freq = [0; 101];
        for &num in nums.iter() {
            freq[num as usize] += 1;
            if freq[num as usize] > 2 {
                return false;
            }
        }
        true
    }
}