use std::collections::HashMap;

impl Solution {
    pub fn max_non_overlapping(nums: Vec<i32>, target: i32) -> i32 {
        let mut sum = 0;
        let mut count = 0;
        let mut seen = HashMap::new();
        seen.insert(0, 1);

        for &num in &nums {
            sum += num;
            if let Some(&v) = seen.get(&(sum - target)) {
                count += 1;
                sum = 0;
                seen.clear();
                seen.insert(0, 1);
            } else {
                seen.insert(sum, 1);
            }
        }

        count
    }
}