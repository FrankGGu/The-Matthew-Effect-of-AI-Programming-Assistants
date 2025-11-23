use std::collections::HashMap;

impl Solution {
    pub fn min_deletions(nums: Vec<i32>, nums_divide: Vec<i32>) -> i32 {
        let gcd = nums_divide.iter().copied().reduce(|a, b| gcd(a, b)).unwrap();
        let mut nums = nums;
        nums.sort();

        for (i, &num) in nums.iter().enumerate() {
            if gcd % num == 0 {
                return i as i32;
            }
        }
        nums.len() as i32
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}