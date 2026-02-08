use std::collections::HashSet;

impl Solution {
    pub fn min_deletions(nums: Vec<i32>, nums_divide: Vec<i32>) -> i32 {
        let gcd = nums_divide.iter().fold(nums_divide[0], |acc, &x| Solution::gcd(acc, x));
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();
        for (i, &num) in sorted_nums.iter().enumerate() {
            if gcd % num == 0 {
                return i as i32;
            }
        }
        -1
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }
}