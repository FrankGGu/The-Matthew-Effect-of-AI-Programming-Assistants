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

        let mut nums = nums;
        nums.sort();

        for &num in &nums {
            if count[&num] > 0 {
                for i in 0..k {
                    let current = num + i;
                    if !count.contains_key(&current) || count[&current] == 0 {
                        return false;
                    }
                    *count.get_mut(&current).unwrap() -= 1;
                }
            }
        }

        true
    }
}