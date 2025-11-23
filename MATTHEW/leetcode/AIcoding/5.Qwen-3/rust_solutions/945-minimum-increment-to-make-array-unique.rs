impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_increments(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let mut seen = HashSet::new();
        let mut res = 0;

        for num in nums {
            if seen.contains(&num) {
                let mut next = num + 1;
                while seen.contains(&next) {
                    next += 1;
                }
                res += next - num;
                seen.insert(next);
            } else {
                seen.insert(num);
            }
        }

        res
    }
}
}