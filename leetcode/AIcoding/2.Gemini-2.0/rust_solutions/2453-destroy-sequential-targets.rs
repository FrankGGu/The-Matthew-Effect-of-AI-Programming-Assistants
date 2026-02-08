use std::collections::HashMap;

impl Solution {
    pub fn destroy_targets(nums: Vec<i32>, space: i32) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        let mut max_count = 0;
        let mut min_val = i32::MAX;

        for &num in &nums {
            let remainder = num.rem_euclid(space);
            let count = counts.entry(remainder).or_insert(0);
            *count += 1;

            if *count > max_count {
                max_count = *count;
            }
        }

        for &num in &nums {
            let remainder = num.rem_euclid(space);
            if counts[&remainder] == max_count {
                min_val = min_val.min(num);
            }
        }

        min_val
    }
}