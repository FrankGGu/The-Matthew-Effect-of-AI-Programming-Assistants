impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn smallest_number(mut nums: Vec<i32>) -> i32 {
        nums.sort_by(|a, b| {
            let a_abs = a.abs();
            let b_abs = b.abs();
            match a_abs.cmp(&b_abs) {
                Ordering::Equal => a.cmp(b),
                other => other,
            }
        });

        let mut result = 0;
        for num in nums {
            result = result * 10 + num.abs();
        }

        if nums[0] < 0 {
            -result
        } else {
            result
        }
    }
}
}