use std::collections::HashSet;

impl Solution {
    pub fn find_max_k(nums: Vec<i32>) -> i32 {
        let mut seen = HashSet::new();
        let mut max_k = -1;

        for &num in &nums {
            if seen.contains(&-num) {
                max_k = max_k.max(num.abs());
            }
            seen.insert(num);
        }

        max_k
    }
}