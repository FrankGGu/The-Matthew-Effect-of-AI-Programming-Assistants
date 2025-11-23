impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn is_possible(target: Vec<i32>) -> bool {
        let mut target = target;
        target.sort_by(|a, b| b.cmp(a));
        let mut total = target.iter().sum::<i32>();
        let mut prev = 0;
        for &t in &target {
            if t == 0 {
                return true;
            }
            if t < prev {
                return false;
            }
            if t > prev {
                let cnt = (t - prev) / (prev as i32);
                if cnt * prev as i32 + prev != t {
                    return false;
                }
                total -= t;
                prev = t;
            }
        }
        true
    }
}
}