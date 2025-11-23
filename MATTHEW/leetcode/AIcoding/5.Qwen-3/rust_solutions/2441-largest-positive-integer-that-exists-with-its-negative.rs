impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn find_max_k(mut nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        for num in &nums {
            set.insert(*num);
        }
        nums.sort_by(|a, b| b.cmp(a));
        for num in nums {
            if num > 0 && set.contains(&-num) {
                return num;
            }
        }
        -1
    }
}
}