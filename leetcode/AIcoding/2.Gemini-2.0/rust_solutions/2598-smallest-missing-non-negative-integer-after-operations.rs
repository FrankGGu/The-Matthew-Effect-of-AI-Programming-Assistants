use std::collections::HashMap;

impl Solution {
    pub fn find_smallest_missing(nums: Vec<i32>, value: i32) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            let rem = (num % value + value) % value;
            *counts.entry(rem).or_insert(0) += 1;
        }

        let mut ans = 0;
        loop {
            let rem = (ans % value + value) % value;
            if let Some(count) = counts.get_mut(&rem) {
                if *count > 0 {
                    *count -= 1;
                    ans += 1;
                } else {
                    break;
                }
            } else {
                break;
            }
        }

        ans
    }
}