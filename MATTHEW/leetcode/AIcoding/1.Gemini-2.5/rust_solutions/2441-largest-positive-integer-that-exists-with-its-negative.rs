use std::collections::HashSet;

impl Solution {
    pub fn find_max_k(nums: Vec<i32>) -> i32 {
        let mut seen = HashSet::new();
        for &num in &nums {
            seen.insert(num);
        }

        let mut max_k = -1;
        for &num in &nums {
            if num > 0 {
                if seen.contains(&(-num)) {
                    max_k = max_k.max(num);
                }
            }
        }
        max_k
    }
}