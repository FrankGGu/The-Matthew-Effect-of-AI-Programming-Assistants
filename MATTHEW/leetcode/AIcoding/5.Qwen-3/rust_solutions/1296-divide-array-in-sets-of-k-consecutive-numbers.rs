impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_possible_divide(nums: Vec<i32>, k: i32) -> bool {
        if nums.len() % k as usize != 0 {
            return false;
        }

        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut sorted_nums = nums.clone();
        sorted_nums.sort();

        for &num in &sorted_nums {
            if *count.get(&num).unwrap() == 0 {
                continue;
            }
            for i in 0..k {
                let current = num + i as i32;
                if *count.get(&current).unwrap_or(&0) == 0 {
                    return false;
                }
                *count.get_mut(&current).unwrap() -= 1;
            }
        }

        true
    }
}
}