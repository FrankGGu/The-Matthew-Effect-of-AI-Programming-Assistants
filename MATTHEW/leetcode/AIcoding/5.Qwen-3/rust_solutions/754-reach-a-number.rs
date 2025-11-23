impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn reach_number(target: i32) -> i32 {
        let mut target = target.abs();
        let mut step = 0;
        let mut sum = 0;

        while sum < target || (sum - target) % 2 != 0 {
            step += 1;
            sum += step;
        }

        step
    }
}
}