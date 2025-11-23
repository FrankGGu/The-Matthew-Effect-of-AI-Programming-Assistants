impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_make_zero(nums: Vec<i32>) -> bool {
        let mut unique_nums = HashSet::new();
        for num in nums {
            if num != 0 {
                unique_nums.insert(num);
            }
        }
        let min = *unique_nums.iter().min().unwrap();
        for num in unique_nums {
            if num % min != 0 {
                return false;
            }
        }
        true
    }
}
}