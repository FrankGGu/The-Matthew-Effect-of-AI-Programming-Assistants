use std::collections::HashMap;

impl Solution {
    pub fn max_frequency(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq: HashMap<i32, i32> = HashMap::new();
        let mut left = 0;
        let mut max_len = 0;
        let mut max_freq = 0;

        for right in 0..nums.len() {
            let count = freq.entry(nums[right]).or_insert(0);
            *count += 1;
            max_freq = max_freq.max(*count);

            while (right - left + 1) as i32 - max_freq > k {
                let count = freq.entry(nums[left]).or_insert(0);
                *count -= 1;
                left += 1;

                max_freq = 0;
                for &val in freq.values(){
                    max_freq = max_freq.max(val);
                }
            }

            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}