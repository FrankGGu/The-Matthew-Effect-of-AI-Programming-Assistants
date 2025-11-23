use std::collections::HashSet;

impl Solution {
    pub fn maximum_strong_pair_xor(nums: Vec<i32>) -> i32 {
        let mut max_xor = 0;
        let nums_set: HashSet<_> = nums.iter().cloned().collect();
        let max_num = *nums.iter().max().unwrap();

        for &x in &nums {
            let upper = x * 2;
            if upper > max_num {
                continue;
            }
            let mut current_xor = 0;
            for i in (0..=30).rev() {
                let mask = 1 << i;
                let desired = current_xor | mask;
                let lower = x - x.min(desired);
                let upper = x + x.min(desired);
                let found = (lower..=upper).any(|y| nums_set.contains(&y) && (x ^ y) >= desired);
                if found {
                    current_xor = desired;
                }
            }
            if current_xor > max_xor {
                max_xor = current_xor;
            }
        }
        max_xor
    }
}