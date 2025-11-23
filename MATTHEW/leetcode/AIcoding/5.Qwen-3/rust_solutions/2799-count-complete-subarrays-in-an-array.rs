impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_complete_subarrays(nums: Vec<i32>) -> i32 {
        let unique_count = nums.iter().collect::<HashSet<_>>().len();
        let mut result = 0;
        let n = nums.len();

        for i in 0..n {
            let mut seen = HashSet::new();
            for j in i..n {
                seen.insert(nums[j]);
                if seen.len() == unique_count {
                    result += 1;
                }
            }
        }

        result as i32
    }
}
}