use std::collections::HashSet;

impl Solution {
    pub fn beautiful_splits(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        for i in 1..n {
            let left = &nums[..i];
            let right = &nums[i..];

            let mut left_unique = HashSet::new();
            for &num in left {
                left_unique.insert(num);
            }

            let mut right_unique = HashSet::new();
            for &num in right {
                right_unique.insert(num);
            }

            if left_unique.len() == right_unique.len() {
                count += 1;
            }
        }
        count
    }
}