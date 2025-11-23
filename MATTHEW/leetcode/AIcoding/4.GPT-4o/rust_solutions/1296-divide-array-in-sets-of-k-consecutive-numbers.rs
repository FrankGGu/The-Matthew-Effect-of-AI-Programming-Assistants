use std::collections::HashMap;

impl Solution {
    pub fn can_divide_into_sets(nums: Vec<i32>, k: i32) -> bool {
        if nums.len() % k as usize != 0 {
            return false;
        }

        let mut count = HashMap::new();
        for num in nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut nums = nums;
        nums.sort();

        for &num in &nums {
            let mut freq = *count.get(&num).unwrap_or(&0);
            if freq == 0 {
                continue;
            }
            for i in 0..k {
                let next_num = num + i;
                if *count.get(&next_num).unwrap_or(&0) < freq {
                    return false;
                }
                *count.entry(next_num).or_insert(0) -= freq;
            }
        }
        true
    }
}