use std::collections::HashMap;

impl Solution {
    pub fn max_non_overlapping(nums: Vec<i32>, target: i32) -> i32 {
        let mut count = 0;
        let mut sum = 0;
        let mut seen: HashMap<i32, i32> = HashMap::new();
        seen.insert(0, 1);
        let mut last_end = -1;

        for i in 0..nums.len() {
            sum += nums[i];
            if seen.contains_key(&(sum - target)) {
                let start = seen.get(&(sum - target)).unwrap();
                if last_end < i as i32 {
                    count += 1;
                    last_end = i as i32;
                }
            }
            seen.insert(sum, i as i32 + 1);
        }

        count
    }
}

struct Solution;