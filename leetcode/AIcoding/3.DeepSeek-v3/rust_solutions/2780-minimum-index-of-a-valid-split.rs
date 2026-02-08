use std::collections::HashMap;

impl Solution {
    pub fn minimum_index(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let dominant = freq.iter()
            .max_by_key(|&(_, &count)| count)
            .map(|(&num, _)| num)
            .unwrap();
        let total = freq[&dominant];

        let mut left_count = 0;
        for i in 0..nums.len() {
            if nums[i] == dominant {
                left_count += 1;
            }
            let right_count = total - left_count;
            if left_count * 2 > (i + 1) as i32 && right_count * 2 > (nums.len() - i - 1) as i32 {
                return i as i32;
            }
        }

        -1
    }
}